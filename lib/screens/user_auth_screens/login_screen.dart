import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../generated/assets.dart';
import '../../utils/app_colors.dart';
import 'widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: AppColors.bgColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .075),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.svgHappyGhost),
              const SizedBox(
                height: 75,
              ),
              Row(
                children: [
                  Text(
                    "login".tr,
                    style: const TextStyle(
                      color: AppColors.c_4f4f4f,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomInputField(
                  obsecure: false,
                  hint: 'email'.tr,
                  icon: Icons.mail_outline_rounded),
              SizedBox(
                height: 15,
              ),
              CustomInputField(
                  obsecure: true,
                  hint: 'password'.tr,
                  icon: Icons.lock_outline_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
