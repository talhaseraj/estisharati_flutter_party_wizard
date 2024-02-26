// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:party_wizard/constants/theme.dart';

import '../../../utils/app_colors.dart';

Widget CustomListtile(
    {required size,
    required IconData icon,
    required title,
    required ontap,
    required subtitle}) {
  return GestureDetector(
    onTap: () => ontap(),
    child: Container(
      height: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: CustomTheme.borderRadius,
      ),
      child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          isThreeLine: true,
          leading: Icon(
            icon,
            size: size.width * .085,
            color: AppColors.c_999999,
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.c_999999,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.c_999999,
          )),
    ),
  );
}
