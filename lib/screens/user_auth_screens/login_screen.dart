import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:party_wizard/controllers/user_auth_controller.dart';
import 'package:party_wizard/utils/helpers.dart';

import '../../generated/assets.dart';
import '../../utils/app_colors.dart';
import 'widgets/custom_input_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserAuthController _ = Get.put(UserAuthController());
    final size = MediaQuery.of(context).size;
    return Material(
        color: AppColors.bgColor,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(
            () => SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .075),
                child: Stack(
                  children: [
                    Form(
                      key: _.loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Assets.svgHappyGhost),

                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: _.isSignup.value ? 0 : 75,
                          ),

                          Row(
                            children: [
                              Text(
                                _.isSignup.value ? "sign_up".tr : "login".tr,
                                style: const TextStyle(
                                  color: AppColors.c_4f4f4f,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          //),
                          const SizedBox(
                            height: 15,
                          ),

                          AnimatedContainer(
                            height: _.isSignup.value ? 90 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: _.isSignup.value
                                ? CustomInputField(
                                    controller: _.usernameController,
                                    onChanged: () {
                                      _.loginFormKey.currentState!.validate();
                                    },
                                    validator: (val) =>
                                        Helpers.validateUserName(val ?? ""),
                                    obsecure: false,
                                    hint: 'username'.tr,
                                    icon: Icons.person_outlined)
                                : const SizedBox.shrink(),
                          ),

                          //),
                          CustomInputField(
                              controller: _.emailController,
                              onChanged: () {
                                _.loginFormKey.currentState!.validate();
                              },
                              validator: (val) =>
                                  Helpers.validateEmail(val ?? ""),
                              obsecure: false,
                              hint: 'email'.tr,
                              icon: Icons.mail_outline_rounded),
                          CustomInputField(
                            controller: _.passwordController,
                            onChanged: () {
                              _.loginFormKey.currentState!.validate();
                            },
                            validator: (val) =>
                                Helpers.validatePassword(val ?? ""),
                            obsecure: true,
                            hint: 'password'.tr,
                            icon: Icons.lock_outline_rounded,
                          ),

                          AnimatedContainer(
                            height: _.isSignup.value ? 90 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: _.isSignup.value
                                ? CustomInputField(
                                    controller: _.confirmPasswordController,
                                    onChanged: () {
                                      _.loginFormKey.currentState!.validate();
                                    },
                                    validator: (val) =>
                                        Helpers.validateConfirmPassword(
                                            val ?? "",
                                            _.passwordController.text),
                                    obsecure: true,
                                    hint: 'confirm_password'.tr,
                                    icon: Icons.lock_outline_rounded,
                                  )
                                : const SizedBox.shrink(),
                          ),

                          AnimatedContainer(
                            height: _.isSignup.value ? 0 : 20,
                            duration: const Duration(milliseconds: 250),
                            child: Row(
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
                          ),

                          const SizedBox(
                            height: 10,
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
                                _.loginFormKey.currentState!.validate();
                              },
                              child: Text(
                                _.isSignup.value ? "sign_up".tr : "login".tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          Text(
                            _.isSignup.value
                                ? "or_signup_with".tr
                                : "or_login_with".tr,
                            style: TextStyle(
                                color: AppColors.hintColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                          InkWell(
                            onTap: () {
                              _.isSignup.value = !_.isSignup.value;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _.isSignup.value
                                      ? "already_a_user".tr
                                      : "are_you_a_new_user".tr,
                                  style: const TextStyle(
                                      color: AppColors.c_4f4f4f),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  _.isSignup.value ? "login".tr : "register".tr,
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                Get.locale!.languageCode == "en"
                                    ? "🇦🇪"
                                    : "🇺🇸",
                                style: TextStyle(
                                    fontSize:
                                        size.width * size.height * 0.0001),
                              ),
                              Text(
                                Get.locale!.languageCode == "en"
                                    ? "العربية"
                                    : "English ",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Lato",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        if (Get.locale!.languageCode == "en") {
                          var locale = const Locale('ar');
                          Get.updateLocale(locale);
                          return;
                        }
                        var locale = const Locale('en');
                        Get.updateLocale(locale);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
