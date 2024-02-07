import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../../utils/app_colors.dart';
import '../../controllers/account_screen_controller.dart';
import '../shimmer.dart';
import 'widgets.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<AccountScreenController>(
        init: AccountScreenController(),
        builder: (_) {
          return Scaffold(
              backgroundColor: AppColors.c_f5f5f5,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: AppColors.c_f5f5f5,
                leading: const BackButton(
                  color: AppColors.c_999999,
                ),
                title: Text(
                  "account".tr,
                ),
              ),
              body: Obx(
                () => _.isLoading.value
                    ? loadingShimmer(size)
                    : Container(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            if (_.isBgUpdate.value)
                              const LinearProgressIndicator(minHeight: 1),
                            CustomListtile(
                                size: size,
                                icon: Icons.person_outline_outlined,
                                title: "full_name".tr,
                                subtitle:
                                    "${_.userProfileResponse!.data!.first.name}",
                                ontap: () {
                                  _showBottomSheet(
                                    context: context,
                                    title: 'edit_name'.tr,
                                    fieldName: 'full_name'.tr,
                                    value: _.userProfileResponse!.data!.first
                                            .name ??
                                        "",
                                    onSubmit: (p0) {
                                      _.updateUserProfile({"name": p0});
                                    },
                                  );
                                }),
                            SizedBox(
                              height: size.width * .025,
                            ),
                            CustomListtile(
                                size: size,
                                icon: Icons.phone_outlined,
                                title: "phone_number".tr,
                                subtitle:
                                    "${_.userProfileResponse!.data!.first.phone}",
                                ontap: () {
                                  _showBottomSheet(
                                    context: context,
                                    onSubmit: (p0) {
                                      _.updateUserProfile({"phone": p0});
                                    },
                                    value: _.userProfileResponse!.data!.first
                                            .phone ??
                                        "",
                                    title: 'edit_phone_number'.tr,
                                    fieldName: 'phone_number'.tr,
                                  );
                                }),
                            SizedBox(
                              height: size.width * .025,
                            ),
                            CustomListtile(
                              size: size,
                              icon: Icons.mail_outline_rounded,
                              title: "email".tr,
                              subtitle:
                                  "${_.userProfileResponse!.data!.first.email}",
                              ontap: () {
                                _showBottomSheet(
                                  context: context,
                                  title: 'edit_email_address'.tr,
                                  fieldName: 'email'.tr,
                                  value: _.userProfileResponse!.data!.first
                                          .email ??
                                      "",
                                  onSubmit: (p0) {
                                    _.updateUserProfile({"email": p0});
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: size.width * .025,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("delete my account");
                                _.deleteMyAccount(context);
                              },
                              child: Container(
                                height: size.width * .22,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    leading: Icon(
                                      Icons.delete_outline,
                                      size: size.width * .085,
                                      color: Colors.redAccent,
                                    ),
                                    title: Text(
                                      "delete_my_account".tr,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.redAccent,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
              ));
        });
  }

  Widget loadingShimmer(Size size) {
    return ShimmerLoading(
        child: Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          CustomListtile(
              size: size,
              icon: Icons.person_outline_outlined,
              title: "full_name".tr,
              subtitle: "USER NAME",
              ontap: () {}),
          SizedBox(
            height: size.width * .025,
          ),
          CustomListtile(
              size: size,
              icon: Icons.phone_outlined,
              title: "phone_number".tr,
              subtitle: "+97150000000",
              ontap: () {}),
          SizedBox(
            height: size.width * .025,
          ),
          CustomListtile(
            size: size,
            icon: Icons.mail_outline_rounded,
            title: "email".tr,
            subtitle: "mail@mail.com",
            ontap: () {},
          ),
          SizedBox(
            height: size.width * .025,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: size.width * .22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: Icon(
                    Icons.delete_outline,
                    size: size.width * .085,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    "delete_my_account".tr,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.redAccent,
                  )),
            ),
          )
        ],
      ),
    ));
  }

  void _showBottomSheet({
    required BuildContext context,
    required String title,
    required String fieldName,
    required String value,
    required Function(String) onSubmit,
  }) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BottomSheetWidget(
          title: title,
          value: value,
          onSubmit: (value) => onSubmit(value),
          fieldName: fieldName,
        );
      },
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  final String title, fieldName, value;
  final Function(String) onSubmit;
  const BottomSheetWidget({
    super.key,
    required this.onSubmit,
    required this.title,
    required this.value,
    required this.fieldName,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  late final TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        child: SizedBox(
          height: size.width,
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
                      widget.title,
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
                          widget.fieldName,
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
                      controller: controller,
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
              const Spacer(),
              InkWell(
                onTap: () {
                  widget.onSubmit(controller.text);
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  height: size.width * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    // Same as the button's shape
                    gradient: const LinearGradient(
                      colors: [AppColors.c_ecc89c, AppColors.c_76644e],
                      // Define your gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'save'.tr,
                      style: TextStyle(
                          fontSize: size.width * .06,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
