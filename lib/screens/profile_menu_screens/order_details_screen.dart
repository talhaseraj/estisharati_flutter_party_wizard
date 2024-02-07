import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../constants/assets.dart';
import '../../controllers/order_details_screen_controller.dart';
import '../shimmer.dart';
import '../widgets.dart';


class OrderDetailsScreen extends StatelessWidget {
  final int orderId;
  OrderDetailsScreen({super.key, required this.orderId});
  final _currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<OrderDetailsScreenController>(
        init: OrderDetailsScreenController(orderId: orderId),
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
                "order_details".tr,
                style: const TextStyle(
                    color: AppColors.c_333333, fontWeight: FontWeight.w600),
              ),
            ),
            body: Obx(() => _.isLoading.value
                ? loadingShimmer(size)
                : Scrollbar(
                    child: ListView(children: [
                      if (_.isBackGroundUpdating.value)
                        const LinearProgressIndicator(minHeight: 1),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              child: PageView(
                                onPageChanged: (index) => _currentPage(index),
                                children: [
                                  ..._.orderDetailResponse!.data!.products!
                                      .mapIndexed((index, element) => Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(
                                                      size.width * .025),
                                                  width: size.width * .4,
                                                  height: size.width * .4,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          element.images!.first,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: size.width * .05,
                                                        bottom:
                                                            size.width * .05),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${element.title}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 14),
                                                        ),
                                                        Text(
                                                          "${element.currency} ${element.discountPrice}/-",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 18),
                                                        ),
                                                        Text(
                                                          "${"delivered".tr}${Helpers.formatDateTime(_.orderDetailResponse!.data!.deliveredDate ?? DateTime(1970))}",
                                                          style:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .c_999999,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _.orderDetailResponse!.data!.products!
                                            .length ??
                                        0, // Replace with the actual number of pages
                                    (index) =>
                                        buildDot(index == _currentPage.value),
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: size.width * .35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(size.width * .05),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "order_date".tr,
                                        style: const TextStyle(
                                            color: AppColors.c_707070,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Text(
                                        Helpers.formatDateTime(_
                                                .orderDetailResponse!
                                                .data!
                                                .deliveredDate ??
                                            DateTime(1970)),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${"order".tr} #",
                                        style: const TextStyle(
                                            color: AppColors.c_707070,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Hero(
                                        tag: _.orderDetailResponse!.data!
                                                .orderNumber ??
                                            "",
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            "${_.orderDetailResponse!.data!.orderNumber}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "order_total".tr,
                                        style: const TextStyle(
                                            color: AppColors.c_707070,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Text(
                                        "${_.orderDetailResponse!.data!.currency} ${_.orderDetailResponse!.data!.totalAmount} (${_.orderDetailResponse!.data!.products!.length} item)",
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.width * .05,
                            ),
                            Text(
                              "payment_details".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: size.width * .025,
                            ),
                            Container(
                              width: double.infinity,
                              height: size.width * .25,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(size.width * .05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "payment_details".tr,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${_.orderDetailResponse!.data!.paymentMethod}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.c_707070),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.width * .05,
                            ),
                            Text(
                              "shipping_address".tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: size.width * .025,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(size.width * .05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${_.orderDetailResponse!.data!.country}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${_.orderDetailResponse!.data!.address1}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.c_707070,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                  )),
          );
        });
  }

  Widget loadingShimmer(Size size) {
    return ShimmerLoading(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * .05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.width * .45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(size.width * .025),
                      width: size.width * .4,
                      height: size.width * .4,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:Icon(Icons.abc),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: size.width * .05, bottom: size.width * .05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sit malesuada",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: size.width * .04),
                            ),
                            Text(
                              "\$599",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: size.width * .05),
                            ),
                            Text(
                              "delivered".trParams({"date": "01/04/2024"}),
                              style: const TextStyle(
                                color: AppColors.c_999999,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.width * .05,
              ),
              Container(
                height: size.width * .35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(size.width * .05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "order_date".tr,
                          style: const TextStyle(
                              color: AppColors.c_707070,
                              fontWeight: FontWeight.w900),
                        ),
                        const Text(
                          "11/05/2024",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${"order".tr} #",
                          style: const TextStyle(
                              color: AppColors.c_707070,
                              fontWeight: FontWeight.w900),
                        ),
                        const Text(
                          "524-568-451511",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "order_total".tr,
                          style: const TextStyle(
                              color: AppColors.c_707070,
                              fontWeight: FontWeight.w900),
                        ),
                        const Text(
                          "USD 14.99 (1 item)",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * .05,
              ),
              Text(
                "payment_details".tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.width * .025,
              ),
              Container(
                width: double.infinity,
                height: size.width * .25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(size.width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "payment_details".tr,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "master card ending with 1247",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.c_707070),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * .05,
              ),
              Text(
                "shipping_address".tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.width * .025,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(size.width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "United Arab Emirates".tr,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "الريحان - Abu Dhabi Sector E-38 57 Al Qaboul St",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.c_707070,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
