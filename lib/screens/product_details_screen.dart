import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:party_wizard/utils/app_colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  final productId;
  ProductDetailsScreen({super.key, required this.productId});
  final _currentPage = 0.obs;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                      _currentPage(index);
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
                                        buildDot(index == _currentPage.value),
                                  ),
                                )),
                            SizedBox(
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
                        const Positioned(
                          right: 20,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
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
        ],
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
