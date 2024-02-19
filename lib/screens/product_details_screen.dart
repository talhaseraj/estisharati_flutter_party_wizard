import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:collection/collection.dart';
import 'package:party_wizard/utils/app_colors.dart';
import 'package:party_wizard/widgets/rating_star_row_widget.dart';
import 'package:party_wizard/widgets/see_more_widget.dart';
import 'package:party_wizard/widgets/show_reviews_widget.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../controllers/product_details_controller.dart';
import 'no_internet_screen.dart';
import 'shimmer.dart';

class ProductDetailsScreen extends StatelessWidget {
  final productId;

  ProductDetailsScreen({
    super.key,
    required this.productId,
  });
  final _pageController = PageController().obs;
  final _currentPage = 0.obs;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<ProductDetailsController>(
        init: ProductDetailsController(productId: productId),
        builder: (_) {
          if (_.noInternet.value) {
            return NoInternetScreen(onTap: () {
              _.updateData();
            });
          }
          return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: Obx(() => _.isLoading.value
                  ? loadingWidget(size)
                  : Scaffold(
                      backgroundColor: AppColors.bgColor,
                      body: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          AspectRatio(
                            aspectRatio: 4 / 4,
                            child: Stack(
                              children: [
                                PageView(
                                  onPageChanged: (index) {
                                    _currentPage(index);
                                  },
                                  children: [
                                    ...List.from(_
                                        .productDetailsResponse!.data!.images!
                                        .mapIndexed(
                                            (index, e) => CachedNetworkImage(
                                                  imageUrl: e,
                                                  fit: BoxFit.cover,
                                                )))
                                  ],
                                ),
                                Column(
                                  children: [
                                    SafeArea(
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: MaterialButton(
                                              padding: EdgeInsets.zero,
                                              elevation: 0,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(18),
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child:
                                                  const Icon(Icons.arrow_back),
                                            ),
                                          ),
                                          const Spacer(),
                                          // Stack(
                                          //   children: [
                                          //     Container(
                                          //       margin: const EdgeInsets.all(5),
                                          //       height: 40,
                                          //       width: 40,
                                          //       decoration: BoxDecoration(
                                          //         color: Colors.white,
                                          //         borderRadius: BorderRadius.circular(10),
                                          //       ),
                                          //       child: const Icon(Icons.shopping_cart_outlined),
                                          //     ),
                                          //     const Positioned(
                                          //       bottom: 0,
                                          //       left: 0,
                                          //       child: CircleAvatar(
                                          //         radius: 10,
                                          //         backgroundColor: AppColors.primaryColor,
                                          //         child: Text(
                                          //           "1",
                                          //           style: TextStyle(
                                          //             color: Colors.white,
                                          //             fontSize: 10,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Obx(() => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: List.generate(
                                                    _
                                                        .productDetailsResponse!
                                                        .data!
                                                        .images!
                                                        .length, // Replace with the actual number of pages
                                                    (index) => buildDot(index ==
                                                        _currentPage.value),
                                                  ),
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 22,
                                              decoration: const BoxDecoration(
                                                color: AppColors.bgColor,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(18),
                                                  topLeft: Radius.circular(18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          right: 20,
                                          child: InkWell(
                                            onTap: () {
                                              _.isSaved(!_.isSaved.value);
                                              _.saveUnsaveProduct();
                                            },
                                            child: CircleAvatar(
                                              radius: 22,
                                              backgroundColor: Colors.white,
                                              child: Obx(
                                                () => Icon(
                                                  _.isSaved.value
                                                      ? Icons.favorite
                                                      : Icons
                                                          .favorite_outline_outlined,
                                                  color: _.isSaved.value
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${_.productDetailsResponse!.data!.title}",
                                    style: const TextStyle(
                                      color: AppColors.c_1e2022,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _showReviews(context: context);
                                      },
                                      child: RatingStarRow(
                                        rating: double.parse(_
                                                .productDetailsResponse!
                                                .data!
                                                .averageRating ??
                                            "0.0"),
                                        size: 15,
                                        showRating: true,
                                      ))
                                ],
                              ),
                              const Spacer(),
                              Text(
                                "${_.productDetailsResponse!.data!.currency} ${_.productDetailsResponse!.data!.price}/-",
                                style:
                                    const TextStyle(color: AppColors.c_77838f),
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "about_product".tr,
                                style: const TextStyle(
                                  color: AppColors.c_1e2022,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          TabBar(controller: _.tabController, tabs: [
                            Tab(
                              child: Text(
                                "specifications".tr,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "overview".tr,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: size.width,
                            child: TabBarView(
                                controller: _.tabController,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      children: [
                                        SpecsWidget(
                                            title: "product_weight".tr,
                                            value:
                                                "${_.productDetailsResponse!.data!.productWeight}"),
                                        SpecsWidget(
                                            title: "color_name".tr,
                                            value:
                                                "${_.productDetailsResponse!.data!.color}"),
                                        // SpecsWidget(
                                        //     title: "gender".tr,
                                        //     value:
                                        //         "${_.productDetailsResponse!.data!.gender}"),
                                        SpecsWidget(
                                          title: "material_composition".tr,
                                          value:
                                              "${_.productDetailsResponse!.data!.materialComposition}",
                                        ),
                                        SpecsWidget(
                                            title: "whats_in_the_box".tr,
                                            value:
                                                "${_.productDetailsResponse!.data!.summary}"),

                                        SpecsWidget(
                                          title: "model_number".tr,
                                          value:
                                              "${_.productDetailsResponse!.data!.modelNumber}",
                                        )
                                      ],
                                    ),
                                  ),
                                  SeeMoreTextWidget(
                                    text: _.productDetailsResponse!.data!
                                            .description ??
                                        "",
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      bottomNavigationBar: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 100,
                        child: Column(
                          children: [
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       padding: const EdgeInsets.all(2),
                            //       decoration: BoxDecoration(
                            //           color: AppColors.c_edecf5,
                            //           borderRadius: BorderRadius.circular(12)),
                            //       child: Row(
                            //         children: [
                            //           SizedBox(
                            //             width: 32,
                            //             height: 32,
                            //             child: MaterialButton(
                            //               shape: const RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.all(
                            //                   Radius.circular(14),
                            //                 ),
                            //               ),
                            //               padding: EdgeInsets.zero,
                            //               elevation: 0,
                            //               color: AppColors.c_5965b1,
                            //               onPressed: () {
                            //                 _.quantity.value--;

                            //                 //  _.totalPrice.value = price * _.quantity.value;
                            //               },
                            //               child: const Icon(
                            //                 Icons.remove,
                            //                 color: Colors.white,
                            //               ),
                            //             ),
                            //           ),
                            //           Obx(
                            //             () => Text(
                            //               "  ${_.quantity.value}  ",
                            //               style: const TextStyle(
                            //                 color: AppColors.c_1e2022,
                            //               ),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             width: 32,
                            //             height: 32,
                            //             child: MaterialButton(
                            //               shape: const RoundedRectangleBorder(
                            //                   borderRadius:
                            //                       BorderRadius.all(Radius.circular(14))),
                            //               padding: EdgeInsets.zero,
                            //               elevation: 0,
                            //               color: AppColors.c_222e6a,
                            //               onPressed: () {
                            //                 _.quantity.value++;
                            //                 //   _.totalPrice.value = price * _.quantity.value;
                            //               },
                            //               child: const Icon(
                            //                 Icons.add,
                            //                 color: Colors.white,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Obx(() => Text(
                            //           "\$${_.totalPrice.value}",
                            //           style: const TextStyle(
                            //             color: AppColors.primaryColor,
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 18,
                            //           ),
                            //         )),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: MaterialButton(
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    bottomRight: Radius.circular(18),
                                  ),
                                ),
                                color: AppColors.primaryColor,
                                height: 60,
                                onPressed: () {
                                  _.addToCart(
                                      quantity: 1, productId: productId);
                                },
                                child: Center(
                                  child: _.addingToCart.value
                                      ? const CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'add_to_cart'.tr,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )));
        });
  }

  Column SpecsWidget({required String title, required String value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: AppColors.brownishGrey),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget loadingWidget(Size size) {
    return Stack(
      children: [
        ShimmerLoading(
          child: Container(
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
            color: AppColors.primaryColor,
            child: Center(
              child: SizedBox(
                height: 60,
                child: ScalingText(
                  "● ● ●",
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: Center(
            child: SizedBox(
              height: 60,
              child: ScalingText(
                "● ● ●",
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _showReviews({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const ShowReviewsWidget();
      },
    );
  }

  Widget buildDot(bool isCurrentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isCurrentPage ? 12 : 10,
      // Adjust the size as needed
      height: isCurrentPage ? 12 : 10,
      decoration: BoxDecoration(
          color: isCurrentPage ? AppColors.primaryColor : Colors.white,
          // Adjust colors as needed
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color:
                  isCurrentPage ? AppColors.primaryColor : AppColors.c_e8e4df)),
    );
  }
}
