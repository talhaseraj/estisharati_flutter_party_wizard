import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../controllers/contactus_screen_controller.dart';
import '../../../utils/helpers.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ContactUsScreenController>(
        init: ContactUsScreenController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppColors.c_f5f5f5,
              iconTheme: const IconThemeData(color: AppColors.backButtonColor),
              title: Text(
                "contact_us".tr,
                style: const TextStyle(
                  color: AppColors.c_333333,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                width: size.width,
                child: Form(
                  key: _.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.width * .1,
                      ),
                      Text(
                        "feel_free_to_drop_us_".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColors.c_b2b2b2,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.width * .15,
                      ),
                      textFormField(
                        hint: "${"your_name".tr}*",
                        controller: _.nameController,
                        validator: (p0) => Helpers.validateField(p0),
                      ),
                      SizedBox(
                        height: size.width * .05,
                      ),
                      textFormField(
                        hint: "${"email_address".tr}*",
                        controller: _.emailController,
                        validator: (p0) => Helpers.validateEmail(p0 ?? ""),
                      ),
                      SizedBox(
                        height: size.width * .05,
                      ),
                      textFormField(
                        hint: "${"phone_number".tr}*",
                        validator: (p0) =>
                            Helpers.validatePhoneNumber(p0 ?? ""),
                        controller: _.phoneController,
                      ),
                      SizedBox(
                        height: size.width * .05,
                      ),
                      TextFormField(
                        controller: _.messageController,
                        validator: (value) => Helpers.validateField(value),
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "message".tr,
                          hintStyle: const TextStyle(color: AppColors.c_7e7e7e),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                color: AppColors.bgColor,
                padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                child: InkWell(
                  onTap: () {
                    _.sendFeedBack();
                    // Get.to(() => const ContactUsSentScreen());
                  },
                  child: Container(
                    height: size.width * .15,
                    width: size.width * .75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      // Same as the button's shape
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.c_ecc89c,
                          AppColors.c_76644e,
                        ],
                        // Define your gradient colors
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Center(
                      child: Obx(
                        () => _.isLoading.value
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'send'.tr,
                                style: TextStyle(
                                    fontSize: size.width * .06,
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

  Widget textFormField({
    hint,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.c_7e7e7e),
      ),
    );
  }
}
