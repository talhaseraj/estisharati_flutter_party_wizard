import 'package:get/get.dart';

class Helpers {
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
}
