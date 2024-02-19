import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../constants/theme.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

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
          "faq".tr,
          style: const TextStyle(
              color: AppColors.c_333333, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            return;
          },
          child: ListView(
            children: [
              faqExpensionTile(
                  "Amet adipiscing?",
                  "Duis pretium gravida enim, vel maximus ligula fermentum a. Sed rhoncus eget ex id egestas. Nam nec nisl placerat, tempus erat a, condimentum metus. Curabitur nulla nisi, lacinia at lobortis at, suscipit at nibh. Proin quis lectus finibus, mollis purus vitae, rutrum neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam sed cursus metus, vel viverra mi. Mauris aliquet egestas eros ac placerat. Proin condimentum ligula at diam euismod fringilla et quis lacus.",
                  size),
              SizedBox(
                height: size.width * .025,
              ),
              faqExpensionTile(
                  "Nec faucibus dictum?",
                  "Duis pretium gravida enim, vel maximus ligula fermentum a. Sed rhoncus eget ex id egestas. Nam nec nisl placerat, tempus erat a, condimentum metus. Curabitur nulla nisi, lacinia at lobortis at, suscipit at nibh. Proin quis lectus finibus, mollis purus vitae, rutrum neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam sed cursus metus, vel viverra mi. Mauris aliquet egestas eros ac placerat. Proin condimentum ligula at diam euismod fringilla et quis lacus.",
                  size),
              SizedBox(
                height: size.width * .025,
              ),
              faqExpensionTile(
                  "Auctor suspendisse?",
                  "Duis pretium gravida enim, vel maximus ligula fermentum a. Sed rhoncus eget ex id egestas. Nam nec nisl placerat, tempus erat a, condimentum metus. Curabitur nulla nisi, lacinia at lobortis at, suscipit at nibh. Proin quis lectus finibus, mollis purus vitae, rutrum neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam sed cursus metus, vel viverra mi. Mauris aliquet egestas eros ac placerat. Proin condimentum ligula at diam euismod fringilla et quis lacus.",
                  size),
            ],
          ),
        ),
      ),
    );
  }

  Widget faqExpensionTile(title, body, Size size) {
    final expansionTileShape = RoundedRectangleBorder(
        borderRadius: CustomTheme.borderRadius,
        side: BorderSide(width: 1, color: Colors.grey.shade300));
    return ExpansionTile(
      shape: expansionTileShape,
      collapsedShape: expansionTileShape,
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
      ),
      childrenPadding: EdgeInsets.only(
          left: size.width * .05,
          right: size.width * .05,
          bottom: size.width * .05),
      children: [
        Text(
          body,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            color: AppColors.brownishGrey,
          ),
        )
      ],
    );
  }
}
