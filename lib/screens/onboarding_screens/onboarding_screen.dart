import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../generated/assets.dart';
import '../../utils/app_colors.dart';

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
            SvgPicture.asset(Assets.svgGhostParty),
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
                  height:50,
                  elevation: 0,
                  color: AppColors.c_f9f9fb,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () {},
                  child: Text(
                    "skip".tr,
                    style: const TextStyle(color: AppColors.c_78789d),
                  ),
                ),
              ),
              const Spacer(flex: 2,),
              Expanded(flex: 3,
                child: MaterialButton(
                  height: 50,
                  elevation: 0,
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () {},
                  child: Text(
                    "next".tr,
                    style: const TextStyle(color: Colors.white),
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
