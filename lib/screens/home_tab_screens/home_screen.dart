import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_wizard/controllers/home_screen_controller.dart';
import 'package:party_wizard/models/all_products_response_model.dart';
import 'package:party_wizard/screens/category_screen.dart';
import 'package:party_wizard/screens/notifications_screen.dart';
import 'package:party_wizard/screens/product_details_screen.dart';
import 'package:party_wizard/utils/app_colors.dart';
import 'package:collection/collection.dart';

import '../../constants/assets.dart';
import '../../constants/constants.dart';
import '../../constants/theme.dart';
import '../../widgets/login_popup.dart';
import '../../widgets/more_loading_widget.dart';
import '../../widgets/product_widget.dart';
import '../no_internet_screen.dart';
import '../shimmer.dart';

class HomeScreen extends StatelessWidget {
  var selectedCategoryId = (-1).obs;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.put(HomeScreenController(context));
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(context),
        builder: (_) {
          if (_.noInternet.value) {
            return NoInternetScreen(onTap: () {
              _.updateData(showShimmer: true);
            });
          }
          return Obx(
            () => _.isLoading.value
                ? loadingShimmer(size)
                : Scaffold(
                    backgroundColor: AppColors.bgColor,
                    appBar: AppBar(
                      toolbarHeight: 40,
                      centerTitle: true,
                      backgroundColor: AppColors.bgColor,
                      elevation: 0,
                      leadingWidth: 90,
                      leading: SvgPicture.asset(Assets.assetsSvgHappyGhost),
                      actions: [
                        InkWell(
                          onTap: () =>
                              Get.to(() => const NotificationsScreen()),
                          child: Container(
                            width: 40,
                            margin: const EdgeInsets.only(right: 20),
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: CustomTheme.borderRadius,
                            ),
                            child: const Icon(Icons.notifications),
                          ),
                        ),
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(60),
                        child: SizedBox(
                          height: 45,
                          child: Column(
                            children: [
                              if (_.isBgUpdate.value)
                                const LinearProgressIndicator(minHeight: 1),
                              if (_.isBgUpdate.value)
                                const SizedBox(
                                  height: 5,
                                ),
                              Expanded(
                                child: ListView(
                                  padding: const EdgeInsets.only(left: 20),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: [
                                    SizedBox(
                                      child: MaterialButton(
                                        elevation: 0,
                                        color: Colors.white,
                                        onPressed: () {
                                          selectedCategoryId(-1);
                                        },
                                        height: 45,
                                        // width: 120,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius:
                                              CustomTheme.borderRadius,
                                        ),

                                        child: Obx(() => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.grid_view,
                                                    color: selectedCategoryId
                                                                .value ==
                                                            -1
                                                        ? AppColors.primaryColor
                                                        : AppColors.c_77838f,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "all".tr,
                                                    style: TextStyle(
                                                        color: selectedCategoryId
                                                                    .value ==
                                                                -1
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .c_77838f,
                                                        fontSize: 18),
                                                  )
                                                ])),
                                      ),
                                    ),
                                    ...List.from(
                                      _.allCategoriesResponse!.data!.mapIndexed(
                                          (index, e) => categoryWidget(
                                                "${Get.locale!.languageCode == "ar" ? e.titleArb : e.title}",
                                                () {
                                                  Get.to(
                                                    CategoryScreen(
                                                        category: e.title ?? "",
                                                        categoryId:
                                                            e.categoryId ?? ""),
                                                  );
                                                },
                                                selectedCategoryId.value ==
                                                    int.parse(
                                                        e.categoryId ?? ""),
                                              )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: SizedBox(
                      height: size.height,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await _.updateData(showShimmer: true);
                        },
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification &&
                                notification.metrics.extentAfter == 0 &&
                                notification.metrics.axis == Axis.vertical) {
                              _.loadMoreData();
                            }
                            return false;
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 10,
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: AppColors.c_77838f,
                                    ),
                                    hintText: "search".tr,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                              ),
                              if (_.allProductsResponse!.data!.isEmpty)
                                Expanded(
                                    child: Center(
                                        child: Text(
                                            "no_products_available_right_now"
                                                .tr))),
                              if (_.allProductsResponse!.data!.isNotEmpty)
                                Expanded(
                                  child: GridView.builder(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    shrinkWrap: true,
                                    itemCount:
                                        _.allProductsResponse!.data!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 3 / 4.8,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      final productData =
                                          _.allProductsResponse!.data![index];
                                      final discount =
                                          productData.discount != "0.00";

                                      return ProductWidget(
                                          addToCart: () async {
                                            await _.addToCart(
                                                quantity: 1,
                                                productId: productData.id);
                                          },
                                          discount: discount,
                                          productData: productData);
                                    },
                                  ),
                                ),
                              MoreLoadingWidget(
                                  isLoadingMore: _.isLoadingMoreData),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        });
  }

  Widget loadingShimmer(Size size) {
    return ShimmerLoading(
      child: ListView(
        children: [
          SizedBox(
            height: size.width * .05,
          ),
          SizedBox(
            height: 45,
            child: ListView(
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                SizedBox(
                  width: 120,
                  child: MaterialButton(
                    elevation: 0,
                    color: Colors.white,
                    onPressed: () {
                      selectedCategoryId(-1);
                    },
                    height: 45,
                    // width: 120,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.grid_view,
                                color: selectedCategoryId.value == -1
                                    ? AppColors.primaryColor
                                    : AppColors.c_77838f,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "all".tr,
                                style: TextStyle(
                                    color: selectedCategoryId.value == -1
                                        ? AppColors.primaryColor
                                        : AppColors.c_77838f,
                                    fontSize: 18),
                              )
                            ])),
                  ),
                ),
                ...List.generate(
                    3,
                    (index) => categoryWidget(
                          "Section$index",
                          () {
                            selectedCategoryId(index);
                          },
                          selectedCategoryId.value == index,
                        )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.c_77838f,
                ),
                hintText: "search".tr,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.width * .05,
          ),
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5),
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {},
                child: Card(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Icon(Icons.image),
                          ),
                          const Divider(),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(
                                left: size.width * .05,
                                right: size.width * .05),
                            width: double.infinity,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Urna mauris",
                                  style: TextStyle(
                                      color: AppColors.c_707070,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "\$99.00",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                      Positioned(
                        top: size.width * .025,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * .025,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                alignment: Alignment.center,
                                height: size.width * .065,
                                width: size.width * .125,
                                color: Colors.black,
                                child: const Text(
                                  "-30%",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
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
        ],
      ),
    );
  }
}
