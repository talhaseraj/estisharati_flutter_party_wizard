// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../../../../utils/app_colors.dart';
import '../../../../controllers/report_problem_controller.dart';
import '../../../../utils/helpers.dart';
import '../../../home_tab_screens/home_tab_screen.dart';

class ReportProblemDetailsScreen extends GetView<ReportProblemController> {
  final String category;
  final int categoryId;

  ReportProblemDetailsScreen({
    super.key,
    required this.category,
    required this.categoryId,
  });

  var selectedValue = "account".tr.obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        iconTheme: const IconThemeData(color: AppColors.backButtonColor),
        title: Text(
          "report_a_problem".tr,
          style: const TextStyle(
              color: AppColors.c_333333, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.width * .05),
          width: size.width,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.width * .2,
                  padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  width: size.width * .9,
                  child: Row(
                    children: [
                      Text(
                        '${'problem_about'.tr} ',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        category,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.width * .05,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '${'tell_us_more_about_the_issue'.tr} ',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: size.width * .025,
                ),
                Container(
                  width: size.width * .9,
                  constraints: BoxConstraints(minHeight: size.width),
                  padding: EdgeInsets.all(size.width * .05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: controller.problemControler,
                    validator: (value) => Helpers.validateField(value),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    maxLength: null,
                    maxLines: null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: size.width * .15,
          child: InkWell(
            onTap: () {
              controller.submitReport(categoryId);
              if (!controller.formKey.currentState!.validate()) {
                return;
              }
              _showDialog(context);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * .05),
              height: size.width * .15,
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
                  'send'.tr,
                  style: TextStyle(
                      fontSize: size.width * .06,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const SentDialog();
        });
  }
}

class SentDialog extends StatelessWidget {
  const SentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * .1),
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.width * .2,
            ),
            Icon(
              FontAwesomeIcons.solidPaperPlane,
              color: AppColors.primaryColor,
              size: size.width * .2,
            ),
            SizedBox(
              height: size.width * .05,
            ),
            Text(
              "thank_you_for_the_report_".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            SizedBox(
              height: size.width * .025,
            ),
            Text(
              "we_have_received_your_message_".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.brownishGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            SizedBox(
              height: size.width * .05,
            ),
            InkWell(
              onTap: () {
                Get.offAll(() => HomeTabScreen());
              },
              child: Container(
                height: size.width * .125,
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
                    'back_home'.tr,
                    style: TextStyle(
                        fontSize: size.width * .05,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.width * .1,
            ),
          ],
        ),
      ),
    );
  }
}
