import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/assets.dart';
import '../utils/app_colors.dart';
import 'home_tab_screens/home_tab_screen.dart';

class OrderPlacedScreen extends StatelessWidget {
  final String orderNumber;
  const OrderPlacedScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        centerTitle: true,
        title: Text("order_placed".tr),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.assetsSvgDoneRound,
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${"thank_you".tr}!",
              style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("${"order_number".tr} $orderNumber"),
            const SizedBox(
              height: 30,
            ),
            Text(
              "your_order_is_placed_".tr,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(color: AppColors.brownishGrey, fontSize: 12),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          height: 60,
          child: MaterialButton(
            elevation: 0,
            color: AppColors.primaryColor,
            onPressed: () {
              Get.offAll(() => HomeTabScreen());
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Hero(
              tag: "button",
              child: Center(
                child: Text(
                  'continue_shopping'.tr,
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
    );
  }
}
