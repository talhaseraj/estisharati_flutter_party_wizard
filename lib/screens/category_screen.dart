// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:party_wizard/constants/theme.dart';
import 'package:party_wizard/controllers/home_screen_controller.dart';

import '../../constants/assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/more_loading_widget.dart';
import '../controllers/cateogory_screen_controller.dart';
import '../widgets/product_widget.dart';
import '../widgets/products_shimmer.dart';
import '../widgets/rating_star_row_widget.dart';
import 'no_internet_screen.dart';
import 'product_details_screen.dart';
import 'shimmer.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  final String categoryId;

  const CategoryScreen(
      {super.key, required this.category, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<CategoryScreenController>(
      init: CategoryScreenController(categoryId),
      builder: (_) {
        if (_.noInternet.value) {
          return NoInternetScreen(onTap: () {
            _.updateData(showShimmer: true);
          });
        }
        return PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(size.width * .1),
                child: AppBar(
                  leading: BackButton(
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  iconTheme:
                      const IconThemeData(color: AppColors.backButtonColor),
                  title: Text(
                    category,
                    style: const TextStyle(
                      color: AppColors.c_333333,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: [
                    if (false)
                      IconButton(
                        onPressed: () {
                          _showFilters(context: context);
                        },
                        icon: const Icon(
                          Icons.tune_outlined,
                          color: AppColors.brownishGrey,
                        ),
                      )
                  ],
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
              ),
              body: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2));
                  return;
                },
                child: Obx(
                  () => _.isLoading.value
                      ? loadingShimmer(size)
                      : NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification &&
                                notification.metrics.extentAfter == 0) {
                              _.loadMoreData();
                            }
                            return false;
                          },
                          child: ListView(
                            children: [
                              if (_.isBgLoading.value)
                                const LinearProgressIndicator(
                                  minHeight: 1,
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 40,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    SubCategoryWidget(
                                      isSelected:
                                          _.selectedSubCategoryId.value == 0,
                                      title: "all".tr,
                                      onPressed: () {
                                        _.selectedSubCategoryId(0);
                                        _.updateData(showShimmer: true);
                                      },
                                    ),
                                    ..._.subCategoriesResponse!.data!
                                        .mapIndexed((i, e) => SubCategoryWidget(
                                              isSelected: _
                                                      .selectedSubCategoryId
                                                      .value ==
                                                  e.id,
                                              title:
                                                  "${Get.locale!.languageCode == "ar" ? e.titleArb : e.title}",
                                              onPressed: () {
                                                _.selectedSubCategoryId(e.id);
                                                _.updateData(showShimmer: true);
                                              },
                                            ))
                                        .toList(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CarouselSlider(
                                items: List.from(
                                  _.bannerResponse!.data!.mapIndexed(
                                    (index, e) => ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height: 200,
                                        child: CachedNetworkImage(
                                          imageUrl: e.imageUrl ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                options: CarouselOptions(
                                  height: size.width * .45,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayInterval: const Duration(seconds: 2),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 500),
                                  viewportFraction: 0.85,
                                ),
                              ),
                              SizedBox(
                                height: size.width * .05,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (_.categoryWiseProductsResponse!.data!.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Center(
                                    child:
                                        Text("no_products_in_this_category".tr),
                                  ),
                                ),
                              if (_.categoryWiseProductsResponse!.data!
                                  .isNotEmpty)
                                Obx(
                                  () => _.isUpdating.value
                                      ? ShimmerLoading(
                                          child: ProductsShimmer(size))
                                      : GridView.builder(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * .05),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: _
                                              .categoryWiseProductsResponse!
                                              .data!
                                              .length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 3 / 4.8,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                            crossAxisCount: 2,
                                          ),
                                          itemBuilder: (ctx, index) {
                                            final product = _
                                                .categoryWiseProductsResponse!
                                                .data![index];
                                            return ProductWidget(
                                              addToCart: () async {
                                                final HomeScreenController _ =
                                                    Get.find();
                                                await _.addToCart(
                                                    quantity: 1,
                                                    productId: product.id);
                                              },
                                              discount:
                                                  product.discount != "0.00",
                                              productData: product,
                                            );
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
            ));
      },
    );
  }

  Widget CategoryWidget({
    required Size size,
    required String title,
    required asset,
    required Function onPressed,
    required bool isSelected,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: size.width * .025,
        bottom: size.width * .025,
        right: size.width * .025,
      ),
      width: size.width * .25,
      height: size.width * .2,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColors.c_f9f7f5, // Set the border color here
          width: 1, // Set the border width
        ),
      ),
      child: InkWell(
        onTap: () => onPressed(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              asset,
              width: size.width * .075,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            Text(
              title,
              style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.c_707070),
            ),
          ],
        ),
      ),
    );
  }

  Widget loadingShimmer(Size size) {
    return ShimmerLoading(
      child: ListView(
        children: [
          SizedBox(
            height: size.width * .05,
          ),
          CarouselSlider(
            items: List.generate(
              3,
              (index) => ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: size.width * .4,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          color: Colors.black,
                          child: Icon(Icons.image),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: size.width * .05,
                              top: size.width * .025,
                              bottom: size.width * .025,
                              right: size.width * .05),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "featured".tr,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Ornare orci molestie",
                                style: TextStyle(fontSize: size.width * .05),
                              ),
                              SizedBox(
                                height: size.width * .0125,
                              ),
                              const Text(
                                "\$99.00",
                                style: TextStyle(
                                  color: AppColors.pinkishGrey,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(
                                height: size.width * .0075,
                              ),
                              const Text(
                                "\$99.00",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("see_product".tr),
                                  Icon(
                                    Get.locale!.languageCode == "ar"
                                        ? Icons
                                            .keyboard_double_arrow_left_rounded
                                        : Icons
                                            .keyboard_double_arrow_right_rounded,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            options: CarouselOptions(
              height: size.width * .45,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.85,
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
                onTap: () {
                  Get.to(() => ProductDetailsScreen(productId: 0),
                      transition: Transition.zoom);
                },
                child: Card(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Hero(
                                tag: "product$index", child: Icon(Icons.image)),
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

  void _showFilters({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const FiltersSheetWidget();
      },
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  final Function onPressed;
  final String title;
  final bool isSelected;

  const SubCategoryWidget({
    super.key,
    required this.onPressed,
    required this.isSelected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: MaterialButton(
        elevation: 0,
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.05)
            : Colors.transparent,
        onPressed: () => onPressed(),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color:
                  isSelected ? AppColors.primaryColor : AppColors.brownishGrey,
            ),
            borderRadius: CustomTheme.borderRadius),
        child: Text(
          title,
          style: TextStyle(
              color:
                  isSelected ? AppColors.primaryColor : AppColors.brownishGrey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}

class FiltersSheetWidget extends StatefulWidget {
  const FiltersSheetWidget({super.key});

  @override
  State<FiltersSheetWidget> createState() => _FiltersSheetWidgetState();
}

class _FiltersSheetWidgetState extends State<FiltersSheetWidget> {
  final _currentRangeValues = const RangeValues(20, 80).obs;
  final _selectedRating = 10.obs;
  final _includeOutOfStock = false.obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
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
                    'filters'.tr,
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
            Container(
              height: size.width * 1.25,
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: ListView(
                children: [
                  SizedBox(
                    height: size.width * .05,
                  ),
                  Text(
                    "price_range".tr,
                    style: const TextStyle(
                        color: AppColors.c_1a1a26,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: size.width * .05,
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        SizedBox(
                            width: size.width * .07,
                            child: Text(
                              "\$${_currentRangeValues.value.start.toPrecision(0).toInt()}",
                              style: const TextStyle(
                                color: AppColors.c_1a1a26,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        Expanded(
                          child: RangeSlider(
                            labels: RangeLabels(
                                _currentRangeValues.value.start.toString(),
                                _currentRangeValues.value.end.toString()),
                            values: _currentRangeValues.value,
                            min: 0,
                            max: 100,
                            onChanged: (RangeValues values) {
                              _currentRangeValues.value = values;
                            },
                          ),
                        ),
                        SizedBox(
                            width: size.width * .07,
                            child: FittedBox(
                              child: Text(
                                "\$${_currentRangeValues.value.end.toPrecision(0).toInt()}",
                                style: const TextStyle(
                                  color: AppColors.c_1a1a26,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      ],
                    );
                  }),
                  SizedBox(
                    height: size.width * .075,
                  ),
                  const Divider(),
                  SizedBox(
                    height: size.width * .05,
                  ),
                  Text(
                    "rating".tr,
                    style: const TextStyle(
                        color: AppColors.c_1a1a26,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: size.width * .05,
                  ),
                  ...List.generate(
                    5,
                    (index) => Obx(() => Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(color: AppColors.c_9f9f9f),
                              activeColor: AppColors.beige,
                              value: _selectedRating.value == index,
                              onChanged: (val) {
                                if (index == _selectedRating.value) {
                                  _selectedRating.value = 100;
                                  return;
                                }
                                _selectedRating.value = index;
                              },
                            ),
                            RatingStarRow(
                                showRating: false,
                                rating: double.parse(index.toString()),
                                size: 25),
                            SizedBox(
                              width: size.width * .0125,
                            ),
                            Text(
                              "&_up".tr,
                              style: const TextStyle(
                                  color: AppColors.brownishGrey),
                            ),
                          ],
                        )),
                  ),
                  Divider(
                    height: size.width * .1,
                  ),
                  Text(
                    "availability".tr,
                    style: const TextStyle(
                        color: AppColors.c_1a1a26,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          side: const BorderSide(color: AppColors.c_9f9f9f),
                          activeColor: AppColors.beige,
                          value: _includeOutOfStock.value,
                          onChanged: (val) {
                            _includeOutOfStock(val);
                          },
                        ),
                      ),
                      Text(
                        "include_out_of_stock".tr,
                        style: const TextStyle(color: AppColors.brownishGrey),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.width * .1,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * .05),
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
                    'apply'.tr,
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
    );
  }
}
