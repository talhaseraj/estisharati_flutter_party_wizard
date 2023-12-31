import 'package:get/get.dart';
import 'package:party_wizard/screens/onboarding_screens/onboarding_screen.dart';

class StartupController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.off(() => const OnBoardingScreen());
    });
    super.onInit();
  }
}
