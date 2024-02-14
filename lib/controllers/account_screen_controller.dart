import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../constants/storeage_constants.dart';
import '../models/user_profile_response_model.dart';
import '../screens/splash_screen.dart';
import '../services/auth_services.dart';
import '../utils/helpers.dart';

class AccountScreenController extends GetxController {
  final isLoading = true.obs,
      isUpdating = false.obs,
      noInternet = false.obs,
      isBgUpdate = false.obs;
  int page = 1;
  final box = GetStorage();
  UserProfileResponse? userProfileResponse;

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }

  initializeData() async {
    isLoading(true);

    if (await Helpers.checkInternetConnectionStatus()) {
      noInternet(false);
    } else {
      isLoading(false);
      noInternet(true);
      Get.snackbar("".tr, "no_internet".tr);

      return;
    }
    await getUserProfile(true);
    isLoading(false);
    updateData(showShimmer: false);
  }

  Future<void> updateData({required bool showShimmer}) async {
    isLoading(showShimmer);
    isBgUpdate(!showShimmer);

    if (await Helpers.checkInternetConnectionStatus()) {
      noInternet(false);
      update();
    } else {
      isLoading(false);
      noInternet(true);
      update();
      Get.snackbar("".tr, "no_internet".tr);

      return;
    }
    page = 1;
    await getUserProfile(false);

    update();

    isLoading(false);
    isBgUpdate(false);
    return;
  }

  Future getUserProfile(isInit) async {
    if (isInit) {
      try {
        userProfileResponse = userProfileResponseFromJson(
            box.read(StorageConstants.userProfile).toString());
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await AuthServices.getUserProfile(
          token: box.read(Constants.accessToken));
      userProfileResponse = userProfileResponseFromJson(res);
      box.write(StorageConstants.userProfile, res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  deleteMyAccount(context) {
    AwesomeDialog(
      context: context,
      title: "please_be_aware_".tr,
      dialogType: DialogType.warning,
      btnOkOnPress: () {
        try {
          AuthServices.deleteUserAccount(
              token: box.read(Constants.accessToken));
          Get.offAll(() => const SplashScreen());
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
      btnCancelOnPress: () {},
    ).show();
  }

  Future updateUserProfile(Map<String, String> params) async {
    isBgUpdate(true);
    isUpdating(true);
    try {
      await AuthServices.updateProfile(
          params: params, token: box.read(Constants.accessToken));
      updateData(showShimmer: false);
    } catch (e) {}
    isUpdating(false);
  }
}
