import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAuthController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  var isSignup = false.obs;
}
