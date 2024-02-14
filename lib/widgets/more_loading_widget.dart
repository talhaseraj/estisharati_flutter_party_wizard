import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../utils/app_colors.dart';

MoreLoadingWidget({required isLoadingMore}) {
  return Obx(
    () => AnimatedContainer(
        alignment: Alignment.topCenter,
        height: isLoadingMore.value ? 50 : 0,
        duration: const Duration(milliseconds: 150),
        child: isLoadingMore.value
            ? Center(
                child: SizedBox(
                  height: 60,
                  child: ScalingText(
                    "● ● ●",
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : const SizedBox.shrink()),
  );
}
