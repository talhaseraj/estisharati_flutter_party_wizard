import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:party_wizard/utils/app_colors.dart';

import '../../constants/assets.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final assets = [
    Assets.assetsPngPartyCaps,
    Assets.assetsPngCakeCandles,
    Assets.assetsPngBeachBag,
    Assets.assetsPngBalloons,
    Assets.assetsPngCostume,
    Assets.assetsPngLollyPops
  ];

  final categories = [
    "party_supplies".tr,
    "birthday".tr,
    "summer".tr,
    "balloons".tr,
    "costumes".tr,
    "candy".tr
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              itemCount: assets.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                childAspectRatio: 190 / 150,
              ),
              itemBuilder: (context, index) {
                final png = assets[index];
                final text = categories[index];
                return AspectRatio(
                  aspectRatio: 190 / 150,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AspectRatio(
                            aspectRatio: 2 / 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.c_DDDEE3.withOpacity(.5),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(1000),
                                  topLeft: Radius.circular(1000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Image.asset(
                                  png,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                text,
                                style:
                                    const TextStyle(color: AppColors.c_77838f),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (false)
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                leading: SvgPicture.asset(Assets.assetsSvgIconsSettings),
                tileColor: Colors.white,
                title: Text(
                  "settings".tr,
                  style: const TextStyle(color: AppColors.c_77838f),
                ),
                iconColor: AppColors.c_77838f,
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.c_77838f,
                  size: 18,
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (false)
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                leading: SvgPicture.asset(Assets.assetsSvgIconsHelpCircle),
                tileColor: Colors.white,
                title: Text(
                  "help_center".tr,
                  style: const TextStyle(color: AppColors.c_77838f),
                ),
                iconColor: AppColors.c_77838f,
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.c_77838f,
                  size: 18,
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            if (false)
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                leading: SvgPicture.asset(Assets.assetsSvgIconsFeatherInfo),
                tileColor: Colors.white,
                title: Text(
                  "about".tr,
                  style: const TextStyle(color: AppColors.c_77838f),
                ),
                iconColor: AppColors.c_77838f,
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.c_77838f,
                  size: 18,
                ),
              ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
