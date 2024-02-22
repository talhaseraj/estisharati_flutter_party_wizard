import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:party_wizard/constants/theme.dart';

import '../../../utils/app_colors.dart';
import '../controllers/cart_screen_controller.dart';
import '../controllers/payment_screen_controller.dart';
import '../models/payment_methods_model.dart';
import '../utils/enum.dart';
import '../utils/helpers.dart';
import 'home_tab_screens/cart_screen.dart';
import 'home_tab_screens/home_tab_screen.dart';
import 'package:collection/collection.dart';

import 'product_details_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<CartScreenController>(
        init: CartScreenController(),
        builder: (_) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                  backgroundColor: AppColors.bgColor,
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: AppColors.bgColor,
                    title: Text(
                      "checkout".tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.c_333333,
                          fontSize: 16),
                    ),
                  ),
                  body: Form(
                    key: _.checkOutFormKey,
                    child: Container(
                      height: size.height,
                      padding: EdgeInsets.only(
                        left: size.width * .05,
                        right: size.width * .05,
                      ),
                      child: Scrollbar(
                        interactive: true,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: ListView(children: [
                          SizedBox(
                            height: size.width,
                            child: ListView(
                                shrinkWrap: true,
                                children: List.from(
                                  _.cartDetailsResponse!.data!.cartDetails!
                                      .mapIndexed(
                                    (index, e) => Padding(
                                      padding: EdgeInsets.only(
                                          top: size.width * .025),
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
                                          _.cartDetailsResponse!.data!
                                              .cartDetails!
                                              .removeAt(index);
                                          _.update();
                                          _.removeFromCartProduct(e.id);
                                        },
                                        onDecrement: () async {
                                          return await _.decrementCart(
                                              quantity: 1,
                                              productId: e.productId);
                                        },
                                        onIncrement: () async {
                                          return await _.addToCart(
                                              quantity: 1,
                                              productId: e.productId);
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
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: CustomTheme.borderRadius),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.width * .05,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * .05,
                                    ),
                                    Text(
                                      "order_details".tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.c_3a6c83,
                                ),
                                SizedBox(
                                  height: size.width * .03,
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * .05),
                                    child: Column(
                                      children: [
                                        tile(
                                          "sub_total".tr,
                                          "${_.orderSummaryResponse!.data!.currency} ${_.orderSummaryResponse!.data!.subTotal}",
                                        ),
                                        SizedBox(
                                          height: size.width * .025,
                                        ),
                                        tile(
                                          "shipping_cost".tr,
                                          "${_.orderSummaryResponse!.data!.currency} ${_.orderSummaryResponse!.data!.shipping}",
                                        ),
                                        SizedBox(
                                          height: size.width * .025,
                                        ),
                                        tile(
                                          "tax".tr,
                                          "${_.orderSummaryResponse!.data!.currency} ${_.orderSummaryResponse!.data!.totalVat}",
                                        ),
                                        SizedBox(
                                          height: size.width * .05,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 72,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: CustomTheme.borderRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "total".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black),
                                ),
                                Text(
                                  "${_.orderSummaryResponse!.data!.currency} ${_.orderSummaryResponse!.data!.total}",
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: CustomTheme.borderRadius),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.width * .05,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * .05,
                                    ),
                                    Text(
                                      "address_details".tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.c_3a6c83,
                                ),
                                SizedBox(
                                  height: size.width * .03,
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * .05),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _.firstNameController,
                                          validator: (value) =>
                                              Helpers.validateField(
                                                  value ?? ""),
                                          decoration: InputDecoration(
                                              hintText: "full_name".tr),
                                        ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        // TextFormField(
                                        //   controller: _.lastNameController,
                                        //   decoration: InputDecoration(
                                        //       hintText: "last_name".tr),
                                        // ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: _.phoneNumberController,
                                          validator: (value) =>
                                              Helpers.validatePhoneNumber(
                                            value ?? "",
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "phone_number".tr,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller:
                                              _.shippingAddressController,
                                          validator: (value) =>
                                              Helpers.validateField(
                                                  value ?? ""),
                                          decoration: InputDecoration(
                                              hintText: "shipping_address".tr),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: _.countryController,
                                          validator: (value) =>
                                              Helpers.validateField(
                                                  value ?? ""),
                                          decoration: InputDecoration(
                                              hintText: "country".tr),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: _.cityController,
                                          validator: (value) =>
                                              Helpers.validateField(
                                                  value ?? ""),
                                          decoration: InputDecoration(
                                              hintText: "city".tr),
                                        ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        // TextFormField(
                                        //   controller:
                                        //       _.nearbyLandamrkController,
                                        //   validator: (value) =>
                                        //       Helpers.validateField(
                                        //           value ?? ""),
                                        //   decoration: InputDecoration(
                                        //       hintText: "nearby_landmark".tr),
                                        // ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  bottomNavigationBar: SafeArea(
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.only(bottom: 20),
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
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius: CustomTheme.borderRadius),
                            color: AppColors.primaryColor,
                            onPressed: () => _.payNow(context),
                            child: Center(
                              child: Obx(() => _.addingOrder.value
                                  ? const CupertinoActivityIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "pay_now".tr,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )));
        });
  }
}

// class CartItemsCard extends StatefulWidget {
//   final Function onTap;
//   final int index;

//   final String imageUrl;

//   const CartItemsCard({
//     super.key,
//     required this.imageUrl,
//     required this.index,
//     required this.onTap,
//   });

//   @override
//   State<CartItemsCard> createState() => _CartItemsCardState();
// }

// class _CartItemsCardState extends State<CartItemsCard> {
//   var numberOfItems = 0.obs;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return InkWell(
//       onTap: () => widget.onTap(),
//       child: Container(
//         padding: EdgeInsets.all(size.width * .025),
//         height: 150,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             AspectRatio(
//               aspectRatio: 200 / 250,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: CachedNetworkImage(
//                   imageUrl: widget.imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(size.width * .025),
//                 child: Column(
//                   children: [
//                     const Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Party Balloons",
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         Icon(
//                           Icons.close,
//                           color: AppColors.c_77838f,
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(2),
//                           decoration: BoxDecoration(
//                               color: AppColors.c_edecf5,
//                               borderRadius: BorderRadius.circular(12)),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 32,
//                                 height: 32,
//                                 child: MaterialButton(
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(14),
//                                     ),
//                                   ),
//                                   padding: EdgeInsets.zero,
//                                   elevation: 0,
//                                   color: AppColors.c_5965b1,
//                                   onPressed: () {
//                                     numberOfItems.value--;
//                                   },
//                                   child: const Icon(
//                                     Icons.remove,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Obx(
//                                 () => Text(
//                                   "  ${numberOfItems.value}  ",
//                                   style: const TextStyle(
//                                     color: AppColors.c_1e2022,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 32,
//                                 height: 32,
//                                 child: MaterialButton(
//                                   shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(14))),
//                                   padding: EdgeInsets.zero,
//                                   elevation: 0,
//                                   color: AppColors.c_222e6a,
//                                   onPressed: () {
//                                     numberOfItems.value++;
//                                   },
//                                   child: const Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Text(
//                           "\$130",
//                           style: TextStyle(
//                             color: AppColors.c_77838f,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

Widget tile(title, price) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "$title".tr,
        style: const TextStyle(
          color: AppColors.brownishGrey,
          fontSize: 14,
        ),
      ),
      Text(
        "$price".tr,
        style: const TextStyle(
          color: AppColors.brownishGrey,
          fontSize: 14,
        ),
      ),
    ],
  );
}

class SelectPaymentMethod extends StatelessWidget {
  final int amount;
  final String orderId;
  SelectPaymentMethod({
    super.key,
    required this.amount,
    required this.orderId,
  });

  final paymentMethods = <PaymentMethodModel>[
    PaymentMethodModel(
      title: "credit_card".tr,
      icon: FontAwesomeIcons.creditCard,
      method: LocalPaymentMethod.card,
    ),
    PaymentMethodModel(
      title: "paypal".tr,
      icon: FontAwesomeIcons.paypal,
      method: LocalPaymentMethod.paypal,
    ),
    // PaymentMethodModel(title: "bank_account".tr, icon: FontAwesomeIcons.bank),
    // PaymentMethodModel(title: "stripe".tr, icon: FontAwesomeIcons.stripe),
    if (false)
      if (Platform.isIOS)
        PaymentMethodModel(
            method: LocalPaymentMethod.applePay,
            title: "apple_pay".tr,
            icon: FontAwesomeIcons.applePay),
    if (false)
      if (Platform.isAndroid)
        PaymentMethodModel(
            method: LocalPaymentMethod.googlePay,
            title: "google_pay".tr,
            icon: FontAwesomeIcons.googlePay),
  ];
  final selectedMethod = 100.obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<PaymentScreenController>(
        init: PaymentScreenController(orderId: orderId),
        builder: (_) {
          return Scaffold(
            body: Form(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                              'payment_method'.tr,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          CloseButton(
                            onPressed: () {
                              Get.offAll(() => HomeTabScreen());
                            },
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            itemBuilder: (context, index) {
                              final data = paymentMethods[index];
                              return Obx(
                                () => _paymentMethodTile(
                                  onTap: () {
                                    selectedMethod.value = index;
                                    if (kDebugMode) {
                                      print(index);
                                    }
                                  },
                                  isSelected: selectedMethod.value == index,
                                  data: data,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Colors.transparent,
                              );
                            },
                            itemCount: paymentMethods.length),
                      ),
                      SizedBox(
                        height: size.width * .1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                margin: EdgeInsets.only(
                  left: size.width * .05,
                  right: size.width * .05,
                  bottom: 20,
                ),
                height: 60,
                child: MaterialButton(
                  elevation: 0,
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  onPressed: () {
                    _.processPayment(
                        method: paymentMethods[selectedMethod.value].method,
                        amount: amount,
                        orderId: orderId);
                  },
                  child: Obx(
                    () => Center(
                      child: _.paymentProcessing.value
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'confirm'.tr,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _paymentMethodTile(
      {required bool isSelected,
      required PaymentMethodModel data,
      required Function onTap}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ? AppColors.primaryColor : AppColors.c_e8e4df,
              width: isSelected ? 2 : 1)),
      child: ListTile(
        onTap: () => onTap(),
        leading: Icon(
          data.icon,
          size: 35,
          color: isSelected ? AppColors.primaryColor : Colors.black,
        ),
        trailing: Text(
          data.title ?? "",
          style: TextStyle(
            color: isSelected ? AppColors.primaryColor : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: isSelected ? 16 : 14,
          ),
        ),
      ),
    );
  }
}
