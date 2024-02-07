import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../models/payment_intent_model.dart';
import '../screens/card_payment_screen.dart';
import '../screens/order_placed_screen.dart';
import '../screens/paypal_payment_screen.dart';
import '../services/payment_services.dart';
import '../utils/enum.dart';

class PaymentScreenController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final billingAddressController = TextEditingController();
  final emailController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expController = TextEditingController();
  final cvcController = TextEditingController();

  final showBack = false.obs;

  final paymentProcessing = false.obs;
  final box = GetStorage();

  final orderId;
  PaymentScreenController({required this.orderId});
  PaymentIntentResponse? paymentIntentResponse;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void processPayment(
      {required LocalPaymentMethod method,
      required amount,
      required orderId}) async {
    if (paymentProcessing.value) {
      return;
    }
    switch (method) {
      case LocalPaymentMethod.card:
        if (kDebugMode) {
          print("Processing card payment");
        }
        try {
          paymentProcessing(true);
          paymentIntentResponse = await PaymentServices.createPaymentintent(
              amount: amount, token: box.read(Constants.accessToken));
          if (paymentIntentResponse!.status == 200) {
            Get.to(() => const CardPaymentScreen());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          paymentProcessing(false);
        }
        paymentProcessing(false);
        break;
      case LocalPaymentMethod.paypal:
        // Process PayPal payment

        Get.to(() => PaypalPaymentScreen(onFinish: (val) {}));
        break;
      case LocalPaymentMethod.googlePay:
        // Process Google Pay payment
        if (kDebugMode) {
          print("Processing Google Pay payment");
        }
        break;
      case LocalPaymentMethod.applePay:
        // Process Apple Pay payment
        if (kDebugMode) {
          print("Processing Apple Pay payment");
        }
        break;
    }
  }

  cardPay() async {
    if (paymentProcessing.value) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }
    if (kDebugMode) {
      print("card form is valid");
    }
    try {
      paymentProcessing(true);

      final Map<String, String> params = {
        "cardno": cardNumberController.text.trim(),
        "month": expController.text.split("/")[0],
        "year": expController.text.split("/")[1],
        "cvv": cvcController.text,
        "amount": paymentIntentResponse!.data!.amount.toString().substring(
            0, paymentIntentResponse!.data!.amount.toString().length - 2),
        "payment_method": "1",
        "name": "${firstNameController.text} ${lastNameController.text}",
        "order_id": "$orderId",
        "email": emailController.text,
        "phone": phoneNumberController.text,
        "address": billingAddressController.text,
      };
      final res = await PaymentServices.ordersPayment(
          params: params, token: box.read(Constants.accessToken));
      if (res.status == 200) {
        Get.offAll(
            () => OrderPlacedScreen(
                  orderNumber: res.data!.orderNumber ?? "",
                ),
            transition: Transition.downToUp,
            duration: const Duration(seconds: 1));
      } else {
        Get.snackbar("payment_failed".tr, "${res.message}");
      }
    } catch (e) {
      if (kDebugMode) {
        Get.snackbar("payment_failed".tr, "payment_failed".tr);
        print(e);
      }
    }
    paymentProcessing(false);
  }
}
