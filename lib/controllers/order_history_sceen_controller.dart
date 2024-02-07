import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../constants/urls.dart';
import '../models/order_history_response.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';

class OrderHistoryScreenController extends GetxController {
  final isLoading = true.obs;

  final noInternet = false.obs;
  final box = GetStorage();
  OrderHistoryResponse? orderHistoryResponse;

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
    await getAllSavedProducts(true);
    isLoading(false);
    updateData(showShimmer: false);
  }

  Future<void> updateData({required bool showShimmer}) async {
    isLoading(showShimmer);
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

    await getAllSavedProducts(false);

    update();

    isLoading(false);
    return;
  }

  Future getAllSavedProducts(isInit) async {
    if (isInit) {
      try {
        orderHistoryResponse = orderHistoryResponseFromJson(
            box.read(Urls.ordersHistoryUrl).toString());
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getOrdersHistory(
          token: box.read(Constants.accessToken));
      orderHistoryResponse = orderHistoryResponseFromJson(res);
      box.write(Urls.ordersHistoryUrl, res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }
}
