import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static String? validateField(String? value) {
    if (value!.isEmpty) {
      return 'this_field_is_required'.tr;
    }
    return null;
  }

  static Future<void> urlLauncher(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'please_enter_your_email'.tr;
    }
    // Regular expression for a simple email validation
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(value)) {
      return 'please_enter_a_valid_email'.tr;
    }
    return null; // Return null to indicate that the input is valid
  }

  static String? validateUserName(String value) {
    if (value.isEmpty) {
      return 'please_enter_username'.tr;
    }

    return null; // Return null to indicate that the input is valid
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'please_enter_a_password'.tr;
    }
    // You can add additional password validation rules here.
    // For example, you can check for minimum length or special characters.
    if (value.length < 6) {
      return 'password_must_be_atleast_'.tr;
    }
    // Add more validation rules as needed.

    return null; // Return null to indicate that the password is valid
  }

  static String? validateConfirmPassword(String value, password) {
    if (value.isEmpty) {
      return 'please_enter_a_password'.tr;
    }
    // You can add additional password validation rules here.
    // For example, you can check for minimum length or special characters.
    if (value != password) {
      return 'password_not_matching'.tr;
    }
    // Add more validation rules as needed.
    return null; // Return null to indicate that the password is valid
  }

//return true if connected
  static Future<bool> checkInternetConnectionStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (kDebugMode) {
      print(connectivityResult);
    }

    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      return false;
    } else {
      return true;
    }
  }

  static String? validatePhoneNumber(String value) {
    // Check if the phone number is empty
    if (value.isEmpty) {
      // return 'Please enter a phone number';
      return 'please_enter_a_phone_number'.tr;
    }

    // Define a regular expression for a common phone number format
    RegExp phoneRegExp = RegExp(r'^\+?\d{1,4}[\s-]?\d{6,}$');

    // Check if the phone number matches the pattern
    if (!phoneRegExp.hasMatch(value)) {
      return "please_enter_a_valid_phone_number".tr;
    }

    // Return null if the phone number is valid
    return null;
  }

  static String stripHtmlIfNeeded(String text) {
    // The regular expression is simplified for an HTML tag (opening or
    // closing) or an HTML escape. We might want to skip over such expressions
    // when estimating the text directionality.
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  static String formatDateTime(DateTime dateTime) {
    // Use Intl package for formatting dates
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final StringBuffer newText = StringBuffer();
    final String trimmed = newValue.text.replaceAll(RegExp(r'\s'), '');

    for (int i = 0; i < trimmed.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText.write(' ');
      }
      newText.write(trimmed[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final StringBuffer newText = StringBuffer();
    final String trimmed = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    for (int i = 0; i < trimmed.length; i++) {
      if (i == 2) {
        newText.write('/');
      }
      newText.write(trimmed[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
