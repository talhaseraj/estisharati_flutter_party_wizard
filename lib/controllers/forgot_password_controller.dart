import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/screens/forgot_password_screens/create_password_screen.dart';

import '../screens/forgot_password_screens/second_forgot_password_screen.dart';
import '../screens/user_auth_screens/login_screen.dart';
import '../services/auth_services.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final otpTextFieldController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isSendingOtp = false.obs;
  final isResendingOtp = false.obs;
  final isVerifyingOtp = false.obs;
  final isCreatingPassword = false.obs;

  Future requestOTP() async {
    isSendingOtp(true);
    try {
      final res =
          await AuthServices.requestOtp({"email": emailController.text});
      if (res.status == 200) {
        Get.snackbar("reset_password".tr, "otp_sent_successfully".tr);

        Get.to(() => const CheckMailScreen());
        await Future.delayed(const Duration(seconds: 1));
        Get.to(() => const CreatePasswordScreen());
      } else if (res.status == 401) {
        Get.snackbar("reset_password".tr, "email_not_valid".tr);
      }
    } catch (e) {
      Get.snackbar("reset_password".tr, "otp_sending_failed".tr);
    }
    isSendingOtp(false);
    return;
  }

  Future resendOtp() async {
    isResendingOtp(true);
    try {
      final res =
          await AuthServices.requestOtp({"email": emailController.text});
      if (res.status == 200) {
        Get.snackbar("reset_password".tr, "otp_sent_successfully".tr);
      } else if (res.status == 401) {
        Get.snackbar("reset_password".tr, "email_not_valid".tr);
      }
    } catch (e) {
      Get.snackbar("reset_password".tr, "otp_sending_failed".tr);
    }
    isResendingOtp(false);
    return;
  }

  Future verifyOtp() async {
    isVerifyingOtp(true);
    try {
      final res = await AuthServices.verifyOtp({
        "email": emailController.text,
        "otp": otpTextFieldController.text,
      });
      if (res.status == 200) {
        Get.snackbar("reset_password".tr, "otp_verified_successfully".tr);
        Get.to(() => CreatePasswordScreen());
      } else if (res.status == 401) {
        Get.snackbar("reset_password".tr, "otp_not_valid".tr);
      }
    } catch (e) {
      Get.snackbar("reset_password", "otp_verifcation_failed".tr);
    }
    isVerifyingOtp(false);
    return;
  }

  Future createPassword() async {
    isCreatingPassword(true);
    try {
      final res = await AuthServices.createPassword({
        "email": emailController.text,
        "password_confirmation": passwordController.text,
        "password": confirmPasswordController.text,
      });
      if (res.status == 200) {
        Get.snackbar("reset_password".tr, "password_created_successfully".tr);
        Get.offAll(() => const LoginScreen());
      } else if (res.status == 422) {
        Get.snackbar("reset_password".tr, "password_not_matching".tr);
      }
    } catch (e) {
      Get.snackbar("reset_password", "password_creation_failed".tr);
    }
    isCreatingPassword(false);
    return;
  }
}
