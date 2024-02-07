import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/constants.dart';
import '../models/order_detail_response_model.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';

class OrderDetailsScreenController extends GetxController {
  final orderId;
  OrderDetailsScreenController({required this.orderId});
  final isLoading = true.obs;
  final isBackGroundUpdating = false.obs;

  final noInternet = false.obs;
  final box = GetStorage();
  OrderDetailResponse? orderDetailResponse;

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }

  initializeData() async {
    isLoading(true);

    if (await Helpers.checkInternetConnectionStatus()) {
      noInternet(false);
    } else {
      isLoading(false);
      noInternet(true);
      Get.snackbar("".tr, "no_internet".tr);

      return;
    }
    await getOrderDetails(true);
    isLoading(false);
    updateData();
  }

  Future<void> updateData() async {
    isBackGroundUpdating(true);

    if (await Helpers.checkInternetConnectionStatus()) {
      noInternet(false);
      update();
    } else {
      isLoading(false);
      noInternet(true);
      update();
      Get.snackbar("".tr, "no_internet".tr);

      return;
    }

    await getOrderDetails(false);

    update();

    isBackGroundUpdating(false);
    return;
  }

  Future getOrderDetails(isInit) async {
    if (isInit) {
      try {
        orderDetailResponse = orderDetailResponseFromJson(
            box.read("orderdetails$orderId").toString());
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getOrderDetails(
          orderId: orderId, token: box.read(Constants.accessToken));
      orderDetailResponse = orderDetailResponseFromJson(res);
      box.write("orderdetails$orderId", res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }
}
