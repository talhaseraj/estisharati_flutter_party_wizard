import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

Widget buildDot(bool isCurrentPage) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: const EdgeInsets.symmetric(horizontal: 5),
    width: isCurrentPage ? 12 : 10,
    // Adjust the size as needed
    height: isCurrentPage ? 12 : 10,
    decoration: BoxDecoration(
        color: isCurrentPage ? AppColors.beige : Colors.white,
        // Adjust colors as needed
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: isCurrentPage ? AppColors.beige : AppColors.c_e8e4df)),
  );
}
