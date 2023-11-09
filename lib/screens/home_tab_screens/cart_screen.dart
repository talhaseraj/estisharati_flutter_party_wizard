import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_wizard/screens/checkout_screen.dart';

import '../../../utils/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        leading:const SizedBox.shrink(),
        title: Text(
          "cart".tr,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.c_333333,
              fontSize: 16),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: size.width * .05,
          right: size.width * .05,
        ),
        child: Column(children: [
          Expanded(
            child: ListView(
              children: List.generate(
                2,
                (index) => Padding(
                  padding: EdgeInsets.only(top: size.width * .025),
                  child: CartItemsCard(
                    imageUrl:
                        "https://picsum.photos/id/${index + 1 * 35}/200/250",
                    onTap: () {
                      if (kDebugMode) {
                        print("tap$index");
                      }
                    },
                    index: index,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "subtotal".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.black),
                ),
                Text(
                  "\$599".tr,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          padding: EdgeInsets.only(
            bottom: size.width * .025,
            left: size.width * .05,
            right: size.width * .05,
          ),
          child: Hero(
            tag: "button",
            child: Material(
              color: Colors.transparent,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: AppColors.primaryColor,
                onPressed: () {
                  Get.to(() => const CheckoutScreen());
                },
                child: Center(
                  child: Text(
                    'proceed_to_buy_'.trParams({"items": 3.toString()}),
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemsCard extends StatefulWidget {
  final Function onTap;
  final int index;

  final String imageUrl;

  const CartItemsCard({
    super.key,
    required this.imageUrl,
    required this.index,
    required this.onTap,
  });

  @override
  State<CartItemsCard> createState() => _CartItemsCardState();
}

class _CartItemsCardState extends State<CartItemsCard> {
  var numberOfItems = 0.obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        padding: EdgeInsets.all(size.width * .025),
        height: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            AspectRatio(
                aspectRatio: 200 / 250,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      fit: BoxFit.cover,
                    ))),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(size.width * .025),
                child: Column(
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Party Balloons",
                          style: TextStyle(fontSize: 14),
                        ),
                        Icon(
                          Icons.close,
                          color: AppColors.c_77838f,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                    numberOfItems.value--;
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  "  ${numberOfItems.value}  ",
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14))),
                                  padding: EdgeInsets.zero,
                                  elevation: 0,
                                  color: AppColors.c_222e6a,
                                  onPressed: () {
                                    numberOfItems.value++;
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
                        const Text(
                          "\$130",
                          style: TextStyle(
                            color: AppColors.c_77838f,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
