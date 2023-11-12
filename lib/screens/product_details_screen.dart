import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/controllers/product_details_screen_controller.dart';

import 'package:party_wizard/utils/app_colors.dart';
import 'package:party_wizard/widgets/rating_star_row_widget.dart';
import 'package:party_wizard/widgets/see_more_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final productId;

  ProductDetailsScreen(
      {super.key, required this.productId, required this.price});

  final price;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _ = Get.put(ProductDetailsScreenController());
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 4,
            child: Stack(
              children: [
                Hero(
                  tag: productId,
                  child: PageView(
                    onPageChanged: (index) {
                      _.currentPage(index);
                    },
                    children: [
                      ...List.generate(
                          5,
                          (index) => CachedNetworkImage(
                                imageUrl:
                                    "https://picsum.photos/id/${index * 10}/300/220",
                                fit: BoxFit.cover,
                              ))
                    ],
                  ),
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
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                          const Spacer(),
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.shopping_cart_outlined),
                              ),
                              const Positioned(
                                bottom: 0,
                                left: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    5, // Replace with the actual number of pages
                                    (index) =>
                                        buildDot(index == _.currentPage.value),
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
                              _.isFavourite(!_.isFavourite.value);
                            },
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              child: Obx(
                                () => Icon(
                                  _.isFavourite.value
                                      ? Icons.favorite
                                      : Icons.favorite_outline_outlined,
                                  color: _.isFavourite.value
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
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Party Balloons",
                    style: TextStyle(
                      color: AppColors.c_1e2022,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RatingStarRow(rating: 5.0, size: 15)
                ],
              ),
              Spacer(),
              Text(
                "\$49.00",
                style: TextStyle(color: AppColors.c_77838f),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
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
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(child: SeeMoreTextWidget()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 160,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: AppColors.c_edecf5,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14),
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          color: AppColors.c_5965b1,
                          onPressed: () {
                            _.quantity.value--;

                            _.totalPrice.value = price * _.quantity.value;
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          "  ${_.quantity.value}  ",
                          style: const TextStyle(
                            color: AppColors.c_1e2022,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: MaterialButton(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          color: AppColors.c_222e6a,
                          onPressed: () {
                            _.quantity.value++;
                            _.totalPrice.value = price * _.quantity.value;
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => Text(
                      "\$${_.totalPrice.value}",
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: AppColors.primaryColor,
                height: 60,
                onPressed: () {},
                child: Text("buy_now".tr,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
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
