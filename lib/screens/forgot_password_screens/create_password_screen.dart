import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:party_wizard/constants/assets.dart';
import 'package:party_wizard/controllers/forgot_password_controller.dart';

import 'package:party_wizard/screens/home_tab_screens/home_tab_screen.dart';

import 'package:party_wizard/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:party_wizard/utils/helpers.dart';
import 'package:party_wizard/widgets/custom_input_field.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

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
          child: Form(
            key: _.createPasswordFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Hero(
                    tag: Assets.assetsSvgHappyGhost,
                    child: SvgPicture.asset(Assets.assetsSvgHappyGhost)),
                const SizedBox(
                  height: 30,
                ),
                Hero(
                  tag: "title",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "create_new_password".tr,
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
                        "your_new_password_should_".tr,
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
                CustomInputField(
                  controller: _.passwordController,
                  onChanged: () {
                    _.createPasswordFormKey.currentState!.validate();
                  },
                  validator: (val) => Helpers.validatePassword(val ?? ""),
                  obsecure: true,
                  hint: 'password'.tr,
                  icon: Icons.lock_outline_rounded,
                ),
                CustomInputField(
                  controller: _.confirmPasswordController,
                  onChanged: () {
                    _.createPasswordFormKey.currentState!.validate();
                  },
                  validator: (val) => Helpers.validateConfirmPassword(
                      val ?? "", _.passwordController.text),
                  obsecure: true,
                  hint: 'confirm_password'.tr,
                  icon: Icons.lock_outline_rounded,
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
                        Get.offAll(HomeTabScreen());
                      },
                      child: Text(
                        "reset_password".tr,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
