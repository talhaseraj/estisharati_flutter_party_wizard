import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:party_wizard/screens/user_auth_screens/login_screen.dart';

import '../../../constants/assets.dart';
import '../../../utils/app_colors.dart';

loginDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return const LoginDialog();
      });
}

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [CloseButton()],
            ),
            SvgPicture.asset(Assets.assetsSvgHappyGhost),
            Text(
              "please_login_to_continue".tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: AppColors.brownishGrey),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 170,
              child: Text(
                "if_you_dont_have_account_".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.brownishGrey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              elevation: 0,
              minWidth: double.infinity,
              color: AppColors.primaryColor,
              onPressed: () => Get.offAll(const LoginScreen()),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              height: 60,
              child: Text(
                "login".tr,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
