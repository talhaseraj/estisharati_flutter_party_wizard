import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/controllers/home_screen_controller.dart';
import 'package:party_wizard/models/all_products_response_model.dart';
import 'package:party_wizard/screens/product_details_screen.dart';
import 'package:party_wizard/utils/app_colors.dart';
import 'package:collection/collection.dart';

import '../../constants/assets.dart';
import '../no_internet_screen.dart';
import '../shimmer.dart';

class HomeScreen extends StatelessWidget {
  var selectedCategoryId = (-1).obs;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                      leadingWidth: 60,
                      leading: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.menu),
                        ),
                      ),
                      title: Text(
                        "home".tr,
                        style: const TextStyle(
                            color: AppColors.c_212326, fontSize: 16),
                      ),
                      actions: [
                        Container(
                          width: 40,
                          margin: const EdgeInsets.only(right: 20),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.notifications),
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
                                          borderRadius:
                                              BorderRadius.circular(18),
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
                                                "${e.title}",
                                                () {
                                                  selectedCategoryId(int.parse(
                                                      e.categoryId ?? ""));
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
                              Expanded(
                                child: GridView.builder(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  shrinkWrap: true,
                                  itemCount:
                                      _.allCategoriesResponse!.data!.length,
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
                                        discount: discount,
                                        productData: productData);
                                  },
                                ),
                              ),
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
                          Expanded(
                            flex: 2,
                            child: Hero(
                                tag: "product$index",
                                child: const Icon(Icons.image)),
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

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.discount,
    required this.productData,
  });

  final bool discount;
  final Product productData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailsScreen(
              price: 49.00,
              productId: 0,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                discount
                    ? Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        height: 42,
                        // width: 42,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: AppColors.c_5965b1,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18))),
                        child: Text(
                          "%${double.parse(productData.discount ?? "").toPrecision(0)}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    : const SizedBox.shrink(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline_rounded,
                    color: AppColors.c_77838f,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 2 / 1.25,
                  child: Hero(
                    tag: productData.id ?? "",
                    child: CachedNetworkImage(
                      imageUrl:
                          // ignore: unnecessary_string_interpolations
                          "${productData.images!.first}",
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, text, progress) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${productData.title}",
                    style: const TextStyle(
                        color: AppColors.c_1e2022, fontSize: 14),
                  ),
                  Text(
                    "${productData.price}",
                    style: const TextStyle(
                        color: AppColors.brownishGrey,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 16),
                  ),
                  Text(
                    "${productData.discountPrice}",
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.c_fdd546,
                      ),
                      Text(
                        "(4.8)",
                        style: TextStyle(color: AppColors.c_77838f),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 35,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      height: 35,
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      color: AppColors.primaryColor,
                      onPressed: () {},
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

Widget categoryWidget(text, onTap, bool selected) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    width: 120,
    child: MaterialButton(
      elevation: 0,
      color: Colors.white,
      onPressed: () => onTap(),
      height: 45,
      // width: 120,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Text(
        text,
        style: TextStyle(
          color: selected ? AppColors.primaryColor : AppColors.c_77838f,
          fontSize: 18,
        ),
      ),
    ),
  );
}
