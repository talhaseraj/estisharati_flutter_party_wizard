import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

import '../../../controllers/payment_screen_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';

class CardPaymentScreen extends StatefulWidget {
  const CardPaymentScreen({super.key});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<PaymentScreenController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          title: Text("card_payment".tr),
          actions: [
            CloseButton(
              onPressed: () => Get.back(),
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Scrollbar(
          thumbVisibility: true,
          child: Form(
            key: _.formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Obx(
                    () => CreditCardWidget(
                      glassmorphismConfig: Glassmorphism(
                        blurX: 1.0,
                        blurY: 1.0,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            AppColors.primaryColor,
                            AppColors.secondaryBlueColor,
                          ],
                          stops: <double>[
                            0,
                            1,
                          ],
                        ),
                      ),
                      obscureCardCvv: false,

                      isChipVisible: true,
                      cardNumber: _.cardNumberController.text,
                      expiryDate: _.expController.text,
                      cardHolderName: "Talha seraj",
                      cvvCode: _.cvcController.text,
                      obscureCardNumber: _.showBack.value,
                      showBackView: _.showBack
                          .value, //true when you want to show cvv(back) view
                      onCreditCardWidgetChange: (CreditCardBrand
                          brand) {}, // Callback for anytime credit card brand is changed
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      _.showBack(false);
                      _.update();
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(16),
                      CreditCardFormatter(),
                    ],
                    keyboardType: TextInputType.number,
                    controller: _.cardNumberController,
                    validator: (value) => Helpers.validateField(value ?? ""),
                    decoration: InputDecoration(hintText: "card_number".tr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * .3,
                          child: TextFormField(
                            controller: _.expController,
                            onChanged: (val) {
                              _.showBack(false);
                              _.update();
                            },
                            validator: (value) =>
                                Helpers.validateField(value ?? ""),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9/]')),
                              LengthLimitingTextInputFormatter(5), // MM/DD
                              ExpiryDateFormatter(),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: "EXP".tr),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .3,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(3),
                            ],
                            onChanged: (val) {
                              _.showBack(true);
                              _.update();
                            },
                            controller: _.cvcController,
                            validator: (value) =>
                                Helpers.validateField(value ?? ""),
                            decoration: InputDecoration(hintText: "CVC".tr),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _.firstNameController,
                    validator: (value) => Helpers.validateField(value ?? ""),
                    decoration: InputDecoration(hintText: "full_name".tr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // TextFormField(
                  //   controller: _.lastNameController,
                  //   decoration: InputDecoration(hintText: "last_name".tr),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  TextFormField(
                    controller: _.phoneNumberController,
                    validator: (value) => Helpers.validatePhoneNumber(
                      value ?? "",
                    ),
                    decoration: InputDecoration(
                      hintText: "phone_number".tr,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // TextFormField(
                  //   controller: _.emailController,
                  //   validator: (value) => Helpers.validateEmail(value ?? ""),
                  //   decoration: InputDecoration(hintText: "email".tr),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // TextFormField(
                  //   controller: _.billingAddressController,
                  //   validator: (value) => Helpers.validateField(value ?? ""),
                  //   decoration: InputDecoration(hintText: "billing_address".tr),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            child: MaterialButton(
              onPressed: () {
                _.cardPay();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(16)),
              color: AppColors.primaryColor,
              child: Center(
                child: Obx(
                  () => Center(
                    child: _.paymentProcessing.value
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'pay'.tr,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
