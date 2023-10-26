import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:party_wizard/controllers/user_auth_controller.dart';
import 'package:party_wizard/utils/helpers.dart';

import '../../generated/assets.dart';
import '../../utils/app_colors.dart';
import 'widgets/custom_input_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserAuthController _ = Get.put(UserAuthController());
    final size = MediaQuery.of(context).size;
    return Material(
      color: AppColors.bgColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .075),
          child: Form(
            key: _.formKey,
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
                    onChanged: () {
                      _.formKey.currentState!.validate();
                    },
                    validator: (val) => Helpers.validateEmail(val ?? ""),
                    obsecure: false,
                    hint: 'email'.tr,
                    icon: Icons.mail_outline_rounded),
                const SizedBox(
                  height: 15,
                ),
                CustomInputField(
                  onChanged: () {
                    _.formKey.currentState!.validate();
                  },
                  validator: (val) => Helpers.validatePassword(val ?? ""),
                  obsecure: true,
                  hint: 'password'.tr,
                  icon: Icons.lock_outline_rounded,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "forgot_password".tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    height: 50,
                    elevation: 0,
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: Text(
                      "login".tr,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "or_login_with".tr,
                  style: TextStyle(
                      color: AppColors.hintColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(
                              color: AppColors.c_eeeeee, width: 2)),
                      onPressed: () {},
                      child: const Icon(
                        FontAwesomeIcons.facebookF,
                        color: AppColors.c_2d63f8,
                      ),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                              color: AppColors.c_eeeeee, width: 2)),
                      onPressed: () {},
                      child: const Icon(
                        FontAwesomeIcons.google,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                              color: AppColors.c_eeeeee, width: 2)),
                      onPressed: () {},
                      child: const Icon(
                        FontAwesomeIcons.apple,
                        color: AppColors.c_2a2a2a,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "are_you_a_new_user".tr,
                      style: TextStyle(color: AppColors.c_4f4f4f),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "register".tr,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
