import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:party_wizard/constants/assets.dart';
import 'package:party_wizard/constants/theme.dart';
import 'package:party_wizard/controllers/user_auth_controller.dart';
import 'package:party_wizard/screens/forgot_password_screens/forgot_password_screen.dart';
import 'package:party_wizard/utils/helpers.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_input_field.dart';
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
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(
            () => SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .075),
                  child: Stack(
                    children: [
                      Form(
                        key: _.loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                                tag: Assets.assetsSvgHappyGhost,
                                child: SvgPicture.asset(
                                    Assets.assetsSvgHappyGhost)),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              height: _.isSignup.value ? 0 : 75,
                            ),
                            Hero(
                              tag: "title",
                              child: Row(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      _.isSignup.value
                                          ? "sign_up".tr
                                          : "login".tr,
                                      style: const TextStyle(
                                        color: AppColors.c_4f4f4f,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AnimatedContainer(
                              height: _.isSignup.value ? 90 : 0,
                              duration: const Duration(milliseconds: 250),
                              child: _.isSignup.value
                                  ? CustomInputField(
                                      controller: _.userNameController,
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
                            Hero(
                              tag: "email input",
                              child: CustomInputField(
                                  controller: _.emailController,
                                  onChanged: () {
                                    _.loginFormKey.currentState!.validate();
                                  },
                                  validator: (val) =>
                                      Helpers.validateEmail(val ?? ""),
                                  obsecure: false,
                                  hint: 'email'.tr,
                                  icon: Icons.mail_outline_rounded),
                            ),

                            AnimatedContainer(
                              height: _.isSignup.value ? 90 : 0,
                              duration: const Duration(milliseconds: 250),
                              child: _.isSignup.value
                                  ? CustomInputField(
                                      controller: _.phoneController,
                                      onChanged: () {
                                        _.loginFormKey.currentState!.validate();
                                      },
                                      validator: (val) =>
                                          Helpers.validatePhoneNumber(
                                              val ?? ""),
                                      obsecure: false,
                                      hint: 'phone'.tr,
                                      icon: Icons.phone)
                                  : const SizedBox.shrink(),
                            ),
                            Hero(
                              tag: "password input",
                              child: CustomInputField(
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
                            ),

                            Hero(
                              tag: "confirm password input",
                              child: AnimatedContainer(
                                height: _.isSignup.value ? 90 : 0,
                                duration: const Duration(milliseconds: 250),
                                child: _.isSignup.value
                                    ? CustomInputField(
                                        controller: _.confirmPasswordController,
                                        onChanged: () {
                                          _.loginFormKey.currentState!
                                              .validate();
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
                            ),

                            AnimatedContainer(
                              height: _.isSignup.value ? 0 : 20,
                              duration: const Duration(milliseconds: 250),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ForgotPasswordScreen());
                                    },
                                    child: Text(
                                      "forgot_password?".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade500),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => SizedBox(
                                  width: double.infinity,
                                  child: Hero(
                                    tag: "button",
                                    child: MaterialButton(
                                      height: 60,
                                      elevation: 0,
                                      color: AppColors.primaryColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius:
                                              CustomTheme.borderRadius),
                                      onPressed: () {
                                        if (_.isSignup.value) {
                                          _.signup(context);
                                          return;
                                        }
                                        _.login(context);
                                      },
                                      child: _.isLoading.value
                                          ? const CupertinoActivityIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              _.isSignup.value
                                                  ? "sign_up".tr
                                                  : "login".tr,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ),
                                  ),
                                )),
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
                                // MaterialButton(
                                //   padding:
                                //       const EdgeInsets.symmetric(vertical: 15),
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(14),
                                //       side: const BorderSide(
                                //           color: AppColors.c_eeeeee, width: 2)),
                                //   onPressed: () {},
                                //   child: const Icon(
                                //     FontAwesomeIcons.facebookF,
                                //     color: AppColors.c_2d63f8,
                                //   ),
                                // ),
                                Obx(() => MaterialButton(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius:
                                              CustomTheme.borderRadius,
                                          side: BorderSide(
                                              color: AppColors.c_eeeeee,
                                              width: 2)),
                                      onPressed: () {
                                        _.googleSignin();
                                      },
                                      child: _.googleLogin.value
                                          ? const CupertinoActivityIndicator(
                                              color: AppColors.primaryColor,
                                            )
                                          : const Icon(
                                              FontAwesomeIcons.google,
                                              color: AppColors.primaryColor,
                                            ),
                                    )),
                                Obx(
                                  () => MaterialButton(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: CustomTheme.borderRadius,
                                        side: BorderSide(
                                            color: AppColors.c_eeeeee,
                                            width: 2)),
                                    onPressed: () {
                                      _.appleSignin();
                                    },
                                    child: _.appleLogin.value
                                        ? const CupertinoActivityIndicator(
                                            color: AppColors.primaryColor,
                                          )
                                        : const Icon(
                                            FontAwesomeIcons.apple,
                                            color: AppColors.c_2a2a2a,
                                          ),
                                  ),
                                )
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
                                    _.isSignup.value
                                        ? "login".tr
                                        : "register".tr,
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
                                    fontSize: 14.0,
                                  ),
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
          ),
        ));
  }
}
