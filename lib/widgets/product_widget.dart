import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../models/all_products_response_model.dart';
import '../screens/product_details_screen.dart';
import '../utils/app_colors.dart';
import 'login_popup.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    super.key,
    required this.discount,
    required this.addToCart,
    required this.productData,
  });

  final bool discount;
  final Function addToCart;
  final Product productData;
  final isAddingToCart = false.obs;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (box.read(Constants.accessToken) == null) {
          loginDialog(context);
          return;
        }
        Get.to(() => ProductDetailsScreen(
              productId: productData.id,
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
                  child: CachedNetworkImage(
                    imageUrl:
                        // ignore: unnecessary_string_interpolations
                        "${productData.images!.first}",
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, text, progress) {
                      return const Center(child: CupertinoActivityIndicator());
                    },
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
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.c_fdd546,
                      ),
                      Text(
                        "(${productData.rate})",
                        style: const TextStyle(color: AppColors.c_77838f),
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
                        onPressed: () async {
                          isAddingToCart(true);
                          await addToCart();
                          isAddingToCart(false);
                        },
                        child: Obx(
                          () => isAddingToCart.value
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                        )),
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
