import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:party_wizard/constants/assets.dart';
import 'package:party_wizard/controllers/home_tab_screen_controller.dart';
import 'package:party_wizard/screens/user_auth_screens/login_screen.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../utils/app_colors.dart';
import '../home_tab_screens/home_tab_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
                tag: Assets.assetsSvgHappyGhost,
                child: SvgPicture.asset(
                  Assets.assetsSvgGhostParty,
                )),
            const SizedBox(
              height: 20,
            ),
            ScalingText(
              'party wizard',
              style: const TextStyle(
                  fontFamily: 'nickainley',
                  color: AppColors.primaryColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: Text(
                "quick_and_easy_shopping_".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.c_222e6a, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: MaterialButton(
                  height: 50,
                  elevation: 0,
                  color: AppColors.c_f9f9fb,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Get.offAll(HomeTabScreen());
                  },
                  child: Text(
                    "skip".tr,
                    style: const TextStyle(
                        color: AppColors.c_78789d, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 3,
                child: Hero(
                  tag: "button",
                  child: MaterialButton(
                    height: 50,
                    elevation: 0,
                    color: AppColors.primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: Text(
                      "next".tr,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
