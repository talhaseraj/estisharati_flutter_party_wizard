// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../constants/theme.dart';
import 'help_center_screens/faq_screen.dart';
import 'help_center_screens/privacy_screen.dart';
import 'help_center_screens/report_problem_screens/report_problem_category_screen.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.bgColor,
          iconTheme: const IconThemeData(color: AppColors.backButtonColor),
          title: Text(
            "help_center".tr,
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
                  title: "faq".tr,
                  ontap: () {
                    Get.to(() => const FaqScreen());
                  }),
              SizedBox(
                height: size.width * .025,
              ),
              CustomListtile(
                  size: size,
                  title: "report_a_problem".tr,
                  ontap: () =>
                      Get.to(() => const ReportProblemCategoryScreen())),
              SizedBox(
                height: size.width * .025,
              ),
              CustomListtile(
                  size: size,
                  title: "privacy".tr,
                  ontap: () => Get.to(() => const PrivacyScreen())),
            ],
          ),
        ));
  }

  Widget CustomListtile({required Size size, required title, required ontap}) {
    return InkWell(
      onTap: () => ontap(),
      child: Container(
        height: size.width * .2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: CustomTheme.borderRadius,
        ),
        child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.black)),
      ),
    );
  }
}
