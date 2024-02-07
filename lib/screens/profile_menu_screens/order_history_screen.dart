// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../constants/constants.dart';
import '../../controllers/order_history_sceen_controller.dart';
import '../no_internet_screen.dart';
import '../shimmer.dart';
import 'order_details_screen.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<OrderHistoryScreenController>(
      init: OrderHistoryScreenController(),
      builder: (_) {
        if (_.noInternet.value) {
          return NoInternetScreen(
            onTap: () {
              _.updateData(showShimmer: true);
            },
          );
        }
        return Scaffold(
          backgroundColor: AppColors.c_f5f5f5,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.c_f5f5f5,
            leading: const BackButton(
              color: AppColors.c_999999,
            ),
            title: Hero(
              tag: "order_history".tr,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "order_history".tr,
                  style: const TextStyle(
                      color: AppColors.c_333333,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          body: Obx(
            () => _.isLoading.value
                ? loadingShimmer(size)
                : _.orderHistoryResponse!.data!.isEmpty
                    ? Center(
                        child: Text("no_data_place_order_first".tr),
                      )
                    : Container(
                        padding: const EdgeInsets.all(8.0),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            _.updateData(showShimmer: true);
                          },
                          child: ListView.separated(
                            itemCount: _.orderHistoryResponse!.data!.length,
                            itemBuilder: (context, index) {
                              final order =
                                  _.orderHistoryResponse!.data![index];
                              return OrderHistoryTile(
                                  imageUrl: order.image ?? "",
                                  date: Helpers.formatDateTime(
                                      order.deliveredDate ?? DateTime(1970)),
                                  size: size,
                                  icon: Icons.lock_outline_rounded,
                                  title: "${order.orderNumber}",
                                  orderStatus: order.orderStatus!.toLowerCase(),
                                  ontap: () {
                                    Get.to(
                                        () => OrderDetailsScreen(
                                              orderId: order.id ?? 0,
                                            ),
                                        transition: Transition.rightToLeft);
                                  });
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(color: Colors.transparent),
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }

  Widget OrderHistoryTile({
    required Size size,
    required IconData icon,
    required String title,
    required String imageUrl,
    required ontap,
    required date,
    required String orderStatus,
  }) {
    Color subTitleColor = Colors.grey;
    if (orderStatus.contains(Constants.shipped)) {
      subTitleColor = Colors.green;
    } else if (orderStatus.contains(Constants.paymentPending)) {
      subTitleColor = Colors.black;
    } else if (orderStatus.contains(Constants.delivered)) {
      subTitleColor = Colors.grey;
    } else if (orderStatus.contains(Constants.cancelled)) {
      subTitleColor = AppColors.brick;
    } else if (orderStatus.contains(Constants.processing)) {
      subTitleColor = AppColors.yellowBrown;
    }

    return InkWell(
      onTap: () => ontap(),
      child: Container(
        height: size.width * .25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          isThreeLine: true,
          leading: Container(
            width: size.width * .15,
            height: size.width * .15,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          subtitle: Text(
            "${orderStatus.tr}$date",
            style: TextStyle(
              color: subTitleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Hero(
            tag: title,
            child: Material(
              color: Colors.transparent,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.c_999999,
          ),
        ),
      ),
    );
  }

  Widget loadingShimmer(Size size) {
    return ShimmerLoading(
        child: Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
          SizedBox(
            height: size.width * .025,
          ),
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
          SizedBox(
            height: size.width * .025,
          ),
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
          SizedBox(
            height: size.width * .025,
          ),
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          OrderHistoryTile(
            imageUrl: "",
            size: size,
            icon: Icons.lock_outline_rounded,
            title: "### #####",
            orderStatus: "####### ",
            date: "00/00/0000",
            ontap: () {},
          ),
        ],
      ),
    ));
  }
}
