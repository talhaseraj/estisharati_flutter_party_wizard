// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:party_wizard/screens/onboarding_screens/onboarding_screen.dart';
import 'package:party_wizard/screens/splash_screen.dart';

import '../../constants/constants.dart';
import '../../constants/theme.dart';
import '../../constants/urls.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import 'account_screen.dart';
import 'contact_us_screens/contact_us_screen.dart';
import 'help_center_screen.dart';
import 'order_history_screen.dart';
import 'security_screen.dart';

class ProfileMenuScreen extends StatelessWidget {
  const ProfileMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        title: Text(
          "settings".tr,
          style: const TextStyle(
              color: AppColors.c_333333, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomListtile(
                size: size,
                icon: Icons.person_outline_outlined,
                title: "account".tr,
                ontap: () => Get.to(() => const AccountScreen())),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
                size: size,
                icon: Icons.lock_outline_rounded,
                title: "security".tr,
                ontap: () => Get.to(() => const SecurityScreen())),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
                size: size,
                icon: Icons.wallet_outlined,
                title: "payment".tr,
                ontap: () {}),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
              size: size,
              icon: Icons.access_time,
              title: "order_history".tr,
              ontap: () => Get.to(
                () => const OrderHistory(),
                transition: Transition.rightToLeft,
              ),
            ),
            if (false)
              SizedBox(
                height: size.width * .025,
              ),
            if (false)
              CustomListtile(
                  size: size,
                  icon: Icons.ads_click_rounded,
                  title: "ads".tr,
                  ontap: () {}),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
                size: size,
                icon: Icons.help_outline_rounded,
                title: "help_center".tr,
                ontap: () => Get.to(() => const HelpCenterScreen())),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
              size: size,
              icon: Icons.info_outline_rounded,
              title: "about".tr,
              ontap: () {
                Helpers.urlLauncher(Urls.aboutUsUrl);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
              size: size,
              icon: Icons.privacy_tip_outlined,
              title: "privacy_policy".tr,
              ontap: () {
                Helpers.urlLauncher(
                  Urls.privacyPolicyUrl,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
              size: size,
              icon: Icons.file_open_outlined,
              title: "terms_&_conditions".tr,
              ontap: () {
                Helpers.urlLauncher(
                  Urls.termsAndConditionsUrl,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
                size: size,
                icon: Icons.support_agent_rounded,
                title: "contact_us".tr,
                ontap: () => Get.to(() => const ContactUsScreen())),
            const SizedBox(
              height: 10,
            ),
            CustomListtile(
                size: size,
                icon: Icons.language_rounded,
                title: Get.locale!.languageCode == "ar" ? "English" : "العربية",
                ontap: () {
                  if (Get.locale!.languageCode == "en") {
                    var locale = const Locale('ar');
                    Get.updateLocale(locale);
                    return;
                  }
                  var locale = const Locale('en');
                  Get.updateLocale(locale);
                }),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                final box = GetStorage();
                GoogleSignIn().signOut();
                box.remove(Constants.accessToken);
                Get.offAll(() => const OnBoardingScreen());
              },
              child: Container(
                margin: EdgeInsets.only(top: size.width * .025),
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.c_707070),
                  borderRadius: CustomTheme.borderRadius,
                ),
                child: Text("logout".tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomListtile(
      {required size, required IconData icon, required title, required ontap}) {
    return InkWell(
      onTap: () => ontap(),
      child: ListTile(
          tileColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: CustomTheme.borderRadius,
          ),
          leading: Icon(
            icon,
            size: 35,
            color: Colors.grey.shade800,
          ),
          title: Hero(
            tag: title,
            child: Material(
              color: Colors.transparent,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
          )),
    );
  }
}
