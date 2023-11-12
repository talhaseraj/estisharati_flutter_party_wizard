import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:party_wizard/constants/assets.dart';
import 'package:party_wizard/utils/app_colors.dart';

class Screen404 extends StatelessWidget {
  const Screen404({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "404",
              style: TextStyle(
                  color: AppColors.c_77838f,
                  fontSize: 82,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "oops_so_sorry".tr,
              style: const TextStyle(
                color: AppColors.c_77838f,
                fontSize: 22,
              ),
            ),
            Text(
              "page_not_found".tr,
              style: const TextStyle(
                  color: AppColors.c_77838f,
                  fontSize: 33,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(Assets.assetsSvgSadGhost)
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 60,
          child: MaterialButton(
            elevation: 0,
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: AppColors.primaryColor,
            child: Text(
              "back_home".tr,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
