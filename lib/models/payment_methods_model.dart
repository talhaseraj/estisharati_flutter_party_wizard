import 'package:flutter/material.dart';

import '../utils/enum.dart';

class PaymentMethodModel {
  const PaymentMethodModel(
      {required this.title, required this.icon, required this.method});
  final String title;
  final LocalPaymentMethod method;
  final IconData icon;
}
