import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:party_wizard/controllers/category_menu_screen_controller.dart';
import 'package:party_wizard/screens/category_screen.dart';
import 'package:party_wizard/screens/shimmer.dart';
import 'package:party_wizard/utils/app_colors.dart';

import '../../constants/assets.dart';
import '../../constants/theme.dart';

class CategoryMenuScreen extends StatelessWidget {
  CategoryMenuScreen({super.key});

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
    return GetBuilder<CategoryMenuScreenController>(
        init: CategoryMenuScreenController(),
        builder: (_) {
          return Obx(() => _.isLoading.value
              ? loadingShimmer()
              : Scaffold(
                  backgroundColor: AppColors.bgColor,
                  body: SafeArea(
                    child: RefreshIndicator(
                      onRefresh: () => _.updateData(showShimmer: true),
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        itemCount: _.allCategoriesResponse!.data!.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2,
                          childAspectRatio: 190 / 150,
                        ),
                        itemBuilder: (context, index) {
                          final e = _.allCategoriesResponse!.data![index];

                          final text =
                              "${Get.locale!.languageCode == "ar" ? e.titleArb : e.title}";

                          return GestureDetector(
                            onTap: () => Get.to(CategoryScreen(
                                category: text,
                                categoryId: e.categoryId ?? "")),
                            child: AspectRatio(
                              aspectRatio: 190 / 150,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: CustomTheme.borderRadius),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: AspectRatio(
                                        aspectRatio: 2 / 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.c_DDDEE3
                                                .withOpacity(.5),
                                            borderRadius:
                                                const BorderRadius.only(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                            child: CachedNetworkImage(
                                              imageUrl: e.imageUrl ?? "",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            text,
                                            style: const TextStyle(
                                                color: AppColors.c_77838f),
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
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ));
        });
  }

  loadingShimmer() {
    return ShimmerLoading(
      child: GridView.builder(
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
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: CustomTheme.borderRadius),
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
                          style: const TextStyle(color: AppColors.c_77838f),
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
    );
  }
}
