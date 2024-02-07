// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../controllers/report_problem_controller.dart';
import '../../../../models/report_categories_response_model.dart';
import 'report_problem_details_screen.dart';

class ReportProblemCategoryScreen extends StatelessWidget {
  const ReportProblemCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ReportProblemController>(
        init: ReportProblemController(),
        builder: (_) {
          return Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.bgColor,
                iconTheme:
                    const IconThemeData(color: AppColors.backButtonColor),
                title: Text(
                  "report_a_problem".tr,
                  style: const TextStyle(
                      color: AppColors.c_333333, fontWeight: FontWeight.w600),
                ),
              ),
              body: Obx(
                () => _.isLoading.value
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : SizedBox(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: size.width * .2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * .05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              width: size.width * .9,
                              child: Row(
                                children: [
                                  Text(
                                    '${'select_category'.tr}:',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  DropdownButton<ReportCategory>(
                                    elevation: 0,

                                    value: _.selectedValue,
                                    // Currently selected value
                                    onChanged: (newValue) {
                                      _.selectedValue =
                                          newValue!; // Update selected value when an item is selected
                                    },
                                    underline: const SizedBox(),

                                    items: <ReportCategory>[
                                      ...List.from(
                                          _.response!.data!.map((e) => e))
                                    ].map<DropdownMenuItem<ReportCategory>>(
                                        (ReportCategory value) {
                                      return DropdownMenuItem<ReportCategory>(
                                        onTap: () {
                                          Get.to(() =>
                                              ReportProblemDetailsScreen(
                                                  categoryId: value.id ?? 0,
                                                  category: Get.locale ==
                                                          const Locale("ar")
                                                      ? value.titleArb ?? ""
                                                      : value.titleEng ?? ""));
                                          return;
                                        },
                                        value: value,
                                        child: Text(
                                          Get.locale == const Locale("ar")
                                              ? value.titleArb ?? ""
                                              : value.titleEng ?? "",
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ));
        });
  }
}
