import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:party_wizard/constants/assets.dart';
import 'package:party_wizard/controllers/forgot_password_controller.dart';
import 'package:party_wizard/screens/forgot_password_screens/create_password_screen.dart';

import 'package:party_wizard/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:party_wizard/utils/helpers.dart';
import 'package:party_wizard/widgets/custom_input_field.dart';

class CheckMailScreen extends StatelessWidget {
  const CheckMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = Get.put(ForgotPasswordController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        iconTheme: const IconThemeData(color: AppColors.c_77838f),
        title: Text(
          "reset_password".tr,
        ),
        titleTextStyle: const TextStyle(
            color: AppColors.c_77838f,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
      backgroundColor: AppColors.bgColor,
      body: InkWell(
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Hero(
                  tag: Assets.assetsSvgHappyGhost,
                  child: SvgPicture.asset(Assets.assetsSvgGhostMail)),
              const SizedBox(
                height: 30,
              ),
              Hero(
                tag: "title",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "check_your_mail".tr,
                    style: const TextStyle(
                        color: AppColors.c_4f4f4f,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Hero(
                tag: "description",
                child: Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: size.width * .85,
                    child: Text(
                      "we_have_sent_a_password_".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: AppColors.c_4f4f4f, fontSize: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: Hero(
                  tag: "button",
                  child: MaterialButton(
                    height: 50,
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {
                      Get.to(() => const CreatePasswordScreen());
                    },
                    child: Text(
                      "open_mail_app".tr,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "skip_ill_confirm_later".tr,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "did_not_receive_email_".tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.c_002333, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "or".tr,
                style: TextStyle(color: AppColors.c_002333, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "try_another_email_address".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
