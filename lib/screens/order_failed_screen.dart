import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/assets.dart';
import '../utils/app_colors.dart';

class OrderFailedScreen extends StatelessWidget {
  const OrderFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text("order_failed".tr),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.assetsSvgCancelRound),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${"ops".tr}!",
              style: const TextStyle(
                  color: AppColors.beige,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("${"oops_something_went_wrong".tr}"),
            const SizedBox(
              height: 30,
            ),
            Text(
              "your_payment_has_been_declined_".tr,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: AppColors.brownishGrey, fontSize: 12),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 80,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Hero(
              tag: "button",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    // Same as the button's shape
                    gradient: const LinearGradient(
                      colors: [AppColors.c_ecc89c, AppColors.c_76644e],
                      // Define your gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'back_to_shopping_cart'.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
