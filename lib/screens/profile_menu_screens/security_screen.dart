import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/constants/theme.dart';

import '../../../utils/app_colors.dart';
import 'widgets.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.bgColor,
          iconTheme: const IconThemeData(
            color: AppColors.backButtonColor,
          ),
          title: Text(
            "security".tr,
            style: const TextStyle(
              color: AppColors.c_333333,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomListtile(
                size: size,
                icon: Icons.lock_outline_rounded,
                title: "password".tr,
                subtitle: "●●●●●●●●●●",
                ontap: () {
                  _showEditPasswordBottomSheet(
                    context: context,
                    textEditingController: TextEditingController(),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

void _showEditPasswordBottomSheet(
    {required BuildContext context,
    required TextEditingController textEditingController}) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return BottomSheetWidget(
        controller: TextEditingController(),
      );
    },
  );
}

class BottomSheetWidget extends StatefulWidget {
  final TextEditingController controller;
  const BottomSheetWidget({super.key, required this.controller});
  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: size.width * .0125,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CloseButton(
                  color: Colors.transparent,
                ),
                Center(
                  child: Text(
                    'edit_password'.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const CloseButton(),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'old_password'.tr,
                        style: const TextStyle(
                            color: AppColors.c_707070,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * .025,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: size.width * .05,
                  ),
                  Row(
                    children: [
                      Text(
                        'new_password'.tr,
                        style: const TextStyle(
                            color: AppColors.c_707070,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * .025,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: size.width * .05,
                  ),
                  Row(
                    children: [
                      Text(
                        'confirm_password'.tr,
                        style: const TextStyle(
                            color: AppColors.c_707070,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width * .025,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.width * .1,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              height: 60,
              child: MaterialButton(
                minWidth: double.infinity,
                color: AppColors.primaryColor,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: CustomTheme.borderRadius),
                onPressed: () {},
                child: Text(
                  'save'.tr,
                  style: TextStyle(
                    fontSize: size.width * .06,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
