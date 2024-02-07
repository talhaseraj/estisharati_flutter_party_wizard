import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../screens/profile_menu_screens/contact_us_screens/contact_us_sent_screen.dart';
import '../services/auth_services.dart';
import '../utils/helpers.dart';

class ContactUsScreenController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  Future sendFeedBack() async {
    if (isLoading.value) {
      return;
    }

    if (await Helpers.checkInternetConnectionStatus()) {
    } else {
      Get.snackbar("".tr, "no_internet".tr);
    }
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading(true);
    try {
      final res = await AuthServices.constactUs(params: {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "message": messageController.text,
      }, token: box.read(Constants.accessToken));
      if (res.status == 200) {
        formKey.currentState!.reset();
        Get.offAll(
          () => const ContactUsSentScreen(),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    isLoading(false);
  }
}
