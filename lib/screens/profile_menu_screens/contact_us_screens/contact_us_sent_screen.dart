import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../home_tab_screens/home_tab_screen.dart';

class ContactUsSentScreen extends StatelessWidget {
  const ContactUsSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.c_f5f5f5,
        iconTheme: const IconThemeData(color: AppColors.backButtonColor),
        title: Text(
          "contact_us".tr,
          style: const TextStyle(
            color: AppColors.c_333333,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "thank_you_for_contacting_us".tr,
              style: const TextStyle(
                color: AppColors.brownishGrey,
                fontWeight: FontWeight.w900,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: size.width * .0125,
            ),
            Text(
              "we_will_be_in_touch_".tr,
              style: const TextStyle(
                color: AppColors.beige,
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: AppColors.bgColor,
          padding: EdgeInsets.symmetric(horizontal: size.width * .05),
          child: InkWell(
            onTap: () {
              Get.offAll(() => HomeTabScreen());
            },
            child: Container(
              height: size.width * .15,
              width: size.width * .75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                // Same as the button's shape
                gradient: const LinearGradient(
                  colors: [
                    AppColors.c_ecc89c,
                    AppColors.c_76644e,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                child: Text(
                  'back_home'.tr,
                  style: TextStyle(
                    fontSize: size.width * .06,
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
