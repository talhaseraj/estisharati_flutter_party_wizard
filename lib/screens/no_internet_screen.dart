import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/assets.dart';
import '../utils/app_colors.dart';

class NoInternetScreen extends StatelessWidget {
  final Function onTap;
  const NoInternetScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppColors.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.assetsSvgNoInternet),
            const SizedBox(
              height: 40,
            ),
            Text(
              "${"no_internet".tr}!",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "please_check_your_internet_connection".tr,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: AppColors.bgColor, fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Get.back();
                onTap();
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                decoration: BoxDecoration(
                
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  "try_again".tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
