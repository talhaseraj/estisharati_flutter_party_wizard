import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../constants/constants.dart';
import '../screens/home_tab_screens/home_tab_screen.dart';
import '../services/auth_services.dart';
import '../utils/helpers.dart';

class UserAuthController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String fcmToken = "asdf";

  final box = GetStorage();

  final isLoading = false.obs;

  final googleLogin = false.obs;
  final appleLogin = false.obs;

  login(context) async {
    try {
      FocusScope.of(context).unfocus();
      if (isLoading.value) {
        return;
      }

      isLoading(true);

      // checking the form validation for email and password
      if (!loginFormKey.currentState!.validate()) {
        isLoading(false);
        return;
      }
      // checking internet
      if (await Helpers.checkInternetConnectionStatus()) {
      } else {
        isLoading(false);

        Get.snackbar("login".tr, "no_internet".tr);

        return;
      }

      final loginResponse = await AuthServices.loginWithEmail({
        "email": emailController.text,
        "password": passwordController.text,
        "firebase_token": fcmToken
      });

      if (loginResponse.status == 401) {
        isLoading(false);
        Get.closeAllSnackbars();
        Get.snackbar("login".tr, "user_not_found".tr);
        return;
      }
      if (loginResponse.status == 200) {
        isLoading(false);
        box.write(Constants.accessToken, loginResponse.user!.accessToken);
        Get.offAll(() => HomeTabScreen());
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar("login".tr, "try_again_later".tr);
    }
  }

  signup(context) async {
    try {
      FocusScope.of(context).unfocus();

      if (isLoading.value) {
        return;
      }

      isLoading(true);

      // checking the form validation for email and password
      if (!signupFormKey.currentState!.validate()) {
        isLoading(false);
        return;
      }
      // checking internet
      if (await Helpers.checkInternetConnectionStatus()) {
      } else {
        isLoading(false);

        Get.snackbar("signup".tr, "no_internet".tr);

        return;
      }
      final signupResponse = await AuthServices.signupWithEmail({
        "name": userNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
        "firebase_token": fcmToken
      });
      if (signupResponse.status == 422) {
        isLoading(false);
        Get.snackbar("sign_up".tr, "email_or_phone_already_registered".tr);
        return;
      }
      if (signupResponse.status == 200) {
        isLoading(false);
        box.write(Constants.accessToken, signupResponse.data!.accessToken);
        Get.off(() => HomeTabScreen());
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Get.snackbar("sign_up".tr, "try_again_later".tr);
    }
  }

  GoogleSignIn google = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  var passVis = true.obs;

  googleSignin() async {
    googleLogin(true);
    try {
      var googleAccount = await google.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleAccount!.authentication;

      final String accessToken = googleSignInAuthentication.accessToken ?? "";
      if (kDebugMode) {
        print("google access token : $accessToken");
      }

      final res = await AuthServices.googleLogin({
        "email": googleAccount.email,
        "name": googleAccount.displayName ?? "User Name",
        "google_id": "1"
      });
      if (res.status == 200) {
        box.write(Constants.accessToken, res.user!.accessToken);
        Get.offAll(() => HomeTabScreen());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar("Google Login", e.toString());
    }
    googleLogin(false);
  }

  appleSignin() async {
    if (!Platform.isIOS) {
      Get.snackbar("login".tr, "available_in_ios_only".tr);
      return;
    }
    appleLogin(true);

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final res = await AuthServices.googleLogin({
        "email": credential.email ?? "",
        "name": "${credential.givenName} ${credential.familyName}",
        "google_id": "1"
      });
      if (res.status == 200) {
        box.write(Constants.accessToken, res.user!.accessToken);
        Get.offAll(() => HomeTabScreen());
      }
    } catch (e) {
      Get.snackbar("", e.toString());
    }
    appleLogin(false);
  }
}
