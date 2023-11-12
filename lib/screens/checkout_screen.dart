import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../models/payment_methods_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
      body: Container(
        height: size.height,
        padding: EdgeInsets.only(
          left: size.width * .05,
          right: size.width * .05,
        ),
        child: ListView(children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: List.generate(
              2,
              (index) => Padding(
                padding: EdgeInsets.only(top: size.width * .025),
                child: Hero(
                  tag: "item$index",
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
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
                          fontSize: 14, fontWeight: FontWeight.bold),
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
                    padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                    child: Column(
                      children: [
                        tile("sub_total".tr, "\$500"),
                        SizedBox(
                          height: size.width * .025,
                        ),
                        tile("shipping_cost".tr, "\$40"),
                        SizedBox(
                          height: size.width * .025,
                        ),
                        tile("tax".tr, "\$5"),
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
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
                          fontSize: 14, fontWeight: FontWeight.bold),
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
                    padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: "shipping_address".tr),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "country".tr),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "city".tr),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: "nearby_landmark".tr),
                        ),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: AppColors.primaryColor,
                onPressed: () {
                  _showPaymentMethodSheet(context);
                },
                child: Center(
                  child: Text(
                    "pay_now".tr,
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

  _showPaymentMethodSheet(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SelectPaymentMethod();
      },
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
                ),
              ),
            ),
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
  SelectPaymentMethod({super.key});

  var paymentMethods = <PaymentMethodModel>[
    PaymentMethodModel(
        title: "credit_card".tr, icon: FontAwesomeIcons.creditCard),
    PaymentMethodModel(title: "paypal".tr, icon: FontAwesomeIcons.paypal),
    PaymentMethodModel(title: "bank_account".tr, icon: FontAwesomeIcons.bank),
    PaymentMethodModel(title: "stripe".tr, icon: FontAwesomeIcons.stripe),
    PaymentMethodModel(title: "apple_pay".tr, icon: FontAwesomeIcons.applePay),
    PaymentMethodModel(
        title: "google_pay".tr, icon: FontAwesomeIcons.googlePay),
  ];
  var selectedMethod = 100.obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                    'payment_method'.tr,
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
            const Divider(
              color: Colors.transparent,
            ),
            ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                itemBuilder: (context, index) {
                  final data = paymentMethods[index];
                  return Obx(() => _paymentMethodTile(
                        onTap: () {
                          selectedMethod.value = index;
                          if (kDebugMode) {
                            print(index);
                          }
                        },
                        isSelected: selectedMethod.value == index,
                        data: data,
                      ));
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.transparent,
                  );
                },
                itemCount: paymentMethods.length),
            SizedBox(
              height: size.width * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
                onPressed: () {
                  Navigator.pop(context);
                },
                color: AppColors.primaryColor,
                height: size.width * .15,
                child: Center(
                  child: Text(
                    'confirm'.tr,
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
    );
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
