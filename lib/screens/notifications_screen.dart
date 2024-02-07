import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_f5f5f5,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.c_f5f5f5,
        leading: const BackButton(
          color: AppColors.c_999999,
        ),
        title: Text(
          "notifications".tr,
        ),
      ),
      body: Center(
        child: Text("no_new_notifications_yet".tr),
      ),
    );
  }
}
