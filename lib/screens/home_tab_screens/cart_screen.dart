import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:party_wizard/constants/theme.dart';

import 'package:party_wizard/controllers/cart_screen_controller.dart';
import 'package:party_wizard/models/cart_details_response_model.dart';
import 'package:party_wizard/screens/checkout_screen.dart';

import '../../../utils/app_colors.dart';
import '../../constants/assets.dart';
import '../product_details_screen.dart';
import '../shimmer.dart';
import 'package:collection/collection.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final emptyCartListWidgets = <Widget>[
    Center(
      child: Lottie.asset(
        Assets.assetsJsonEmptyCartAnimation,
        alignment: Alignment.center,
      ),
    ),
    Text(
      "your_cart_is_empty".tr,
      style: const TextStyle(
          color: AppColors.brownishGrey,
          fontSize: 16,
          fontWeight: FontWeight.bold),
    ),
    Padding(
      padding: const EdgeInsets.all(30),
      child: Text(
        "looks_like_you_havent_added_any_item_".tr,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.brownishGrey, fontSize: 14),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<CartScreenController>(
        init: CartScreenController(),
        builder: (_) {
          return Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: AppColors.bgColor,
                leading: const SizedBox.shrink(),
                title: Text(
                  "cart".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.c_333333,
                      fontSize: 16),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: _.isBgUpdating.value
                      ? const LinearProgressIndicator(minHeight: 1)
                      : SizedBox(height: 0),
                ),
              ),
              body: Builder(builder: (context) {
                // ignore: curly_braces_in_flow_control_structures
                if (!_.isLoading.value) if (_
                    .cartDetailsResponse!.data!.cartDetails!.isEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: emptyCartListWidgets,
                  );
                }
                return Obx(() => _.isLoading.value
                    ? loadingShimmer(size)
                    : Container(
                        padding: EdgeInsets.only(
                          left: size.width * .05,
                          right: size.width * .05,
                        ),
                        child: Column(children: [
                          Expanded(
                            child: ListView(
                                children: List.from(
                              _.cartDetailsResponse!.data!.cartDetails!
                                  .mapIndexed(
                                (index, e) => Padding(
                                  padding:
                                      EdgeInsets.only(top: size.width * .025),
                                  child: CartItemsCard(
                                    imageUrl: e.images!.first,
                                    onTap: () {
                                      Get.to(() => ProductDetailsScreen(
                                            productId: int.parse(
                                              e.productId ?? "0",
                                            ),
                                          ));
                                    },
                                    onRemove: () {
                                      _.cartDetailsResponse!.data!.cartDetails!
                                          .removeAt(index);
                                      _.update();
                                      _.removeFromCartProduct(e.id);
                                    },
                                    onDecrement: () async {
                                      return await _.decrementCart(
                                          quantity: 1, productId: e.productId);
                                    },
                                    onIncrement: () async {
                                      return await _.addToCart(
                                          quantity: 1, productId: e.productId);
                                    },
                                    index: index,
                                    cartDetail: e,
                                  ),
                                ),
                              ),
                            )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (_.cartDetailsResponse!.data!.cartDetails!
                              .isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              height: 72,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: CustomTheme.borderRadius,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "subtotal".tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "${_.cartDetailsResponse!.data!.currency} ${_.cartDetailsResponse!.data!.totalAmount}/-",
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
                      ));
              }),
              bottomNavigationBar: SafeArea(
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(
                    bottom: size.width * .025,
                    left: size.width * .05,
                    right: size.width * .05,
                  ),
                  child: Obx(
                    () => _.isLoading.value
                        ? const SizedBox.shrink()
                        : _.cartDetailsResponse!.data!.cartDetails!.isEmpty
                            ? const SizedBox.shrink()
                            : Hero(
                                tag: "button",
                                child: MaterialButton(
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: CustomTheme.borderRadius),
                                  color: AppColors.primaryColor,
                                  onPressed: () {
                                    Get.to(() => const CheckoutScreen());
                                  },
                                  child: Center(
                                    child: Text(
                                      'proceed_to_buy_'.trParams({
                                        "items":
                                            "${_.cartDetailsResponse!.data!.cartDetails!.length}"
                                      }),
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
              ));
        });
  }

  Widget loadingShimmer(Size size) {
    return ShimmerLoading(
      child: Container(
        padding: EdgeInsets.only(
          top: size.width * .05,
          left: size.width * .05,
          right: size.width * .05,
        ),
        child: Column(children: [
          Container(
            height: size.width * .25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "subtotal".tr,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  "\$999".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                2,
                (index) => Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class CartItemsCard extends StatefulWidget {
  final Function onTap, onRemove, onIncrement, onDecrement;

  final int index;

  final String imageUrl;
  final CartDetail cartDetail;

  const CartItemsCard({
    super.key,
    required this.imageUrl,
    required this.index,
    required this.onTap,
    required this.onRemove,
    required this.onDecrement,
    required this.onIncrement,
    required this.cartDetail,
  });

  @override
  State<CartItemsCard> createState() => _CartItemsCardState();
}

class _CartItemsCardState extends State<CartItemsCard> {
  final isIncrement = false.obs, isDecrement = false.obs;
  var numberOfItems = 0.obs;

  @override
  void initState() {
    numberOfItems(int.parse(widget.cartDetail.quantity ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        padding: EdgeInsets.all(size.width * .025),
        height: 150,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: CustomTheme.borderRadius,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.cartDetail.title}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        IconButton(
                            onPressed: () => widget.onRemove(),
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.c_77838f,
                            )),
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
                                    onPressed: () async {
                                      isDecrement(true);
                                      final res = await widget.onDecrement();
                                      if (res ?? false) {
                                        numberOfItems--;
                                      }
                                      isDecrement(false);
                                    },
                                    child: Obx(
                                      () => isDecrement.value
                                          ? const CupertinoActivityIndicator(
                                              color: Colors.white,
                                            )
                                          : const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                    )),
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
                                    onPressed: () async {
                                      isIncrement(true);
                                      final res = await widget.onIncrement();
                                      if (res ?? false) {
                                        numberOfItems++;
                                      }

                                      isIncrement(false);
                                    },
                                    child: Obx(
                                      () => isIncrement.value
                                          ? const CupertinoActivityIndicator(
                                              color: Colors.white,
                                            )
                                          : const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${widget.cartDetail.currency} ${widget.cartDetail.discountPrice}",
                          style: const TextStyle(
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
