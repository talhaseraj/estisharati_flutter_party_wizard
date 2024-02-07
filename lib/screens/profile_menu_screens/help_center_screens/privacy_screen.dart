import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
     appBar: AppBar(
       elevation: 0,
       backgroundColor: AppColors.bgColor,
       iconTheme: const IconThemeData(color: AppColors.backButtonColor),
       title: Text(
         "privacy".tr,
         style: const TextStyle(
             color: AppColors.c_333333, fontWeight: FontWeight.w600),
       ),
     ),
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * .05),

          child: const Text(
            "Duis pretium gravida enim, vel maximus ligula fermentum a. Sed rhoncus eget ex id egestas. Nam nec nisl placerat, tempus erat a, condimentum metus. Curabitur nulla nisi, lacinia at lobortis at, suscipit at nibh. Proin quis lectus finibus, mollis purus vitae, rutrum neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam sed cursus metus, vel viverra mi. Mauris aliquet egestas eros ac placerat. Proin condimentum ligula at diam euismod fringilla et quis lacus.Duis pretium gravida enim, vel maximus ligula fermentum a. Sed rhoncus eget ex id egestas. Nam nec nisl placerat, tempus erat a, condimentum metus. Curabitur nulla nisi, lacinia at lobortis at, suscipit at nibh. Proin quis lectus finibus, mollis purus vitae, rutrum neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam sed cursus metus, vel viverra mi. Mauris aliquet egestas eros ac placerat. Proin condimentum ligula at diam euismod fringilla et quis lacus.Duis pretium gravida enim, vel maximus ligula fermentum a. Sed rhoncus eget ex id egestas. Nam nec nisl placerat, tempus erat a, condimentum metus. Curabitur nulla nisi, lacinia at lobortis at, suscipit at nibh. Proin quis lectus finibus, mollis purus vitae, rutrum neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam sed cursus metus, vel viverra mi. Mauris aliquet egestas eros ac placerat. Proin condimentum ligula at diam euismod fringilla et quis lacus.Duis pretium gravida enim, vel maximus ligula fermentum a. Sed rhoncus eget ex id egestas. Nam nec nisl placerat, tempus erat a, condimentum metus. Curabitur nulla nisi, lacinia at lobortis at, suscipit at nibh. Proin quis lectus finibus, mollis purus vitae, rutrum neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam sed cursus metus, vel viverra mi. Mauris aliquet egestas eros ac placerat. Proin condimentum ligula at diam euismod fringilla et quis lacus.",
          textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
