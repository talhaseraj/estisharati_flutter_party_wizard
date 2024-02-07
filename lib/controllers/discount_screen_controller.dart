import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/discount_product_response_model.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';

class DiscountScreenController extends GetxController {
  final isLoading = true.obs;
  final isBgLoading = false.obs;
  final noInternet = false.obs;

  final selectedSortId = 0.obs;

  final isLoadingMoreData = false.obs;
  int page = 1;
  final box = GetStorage();

  DiscountProductsResponse? discountProductsResponse;

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }

  initializeData() async {
    isLoading(true);

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

    await getAllDiscountProducts(true);
    isLoading(false);
    updateData(showShimmer: false);
  }

  Future<void> updateData({required bool showShimmer}) async {
    if (showShimmer) {
      isLoading(true);
    }
    isBgLoading(!showShimmer);
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
    page = 1;

    await getAllDiscountProducts(false);

    update();
    isBgLoading(false);
    isLoading(false);
    return;
  }

  Future getAllDiscountProducts(isInit) async {
    page = 1;
    if (isInit) {
      try {
        discountProductsResponse =
            discountProductsResponseFromJson(box.read("discount").toString());

        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getAllDiscountProducts(
        page: page,
      );
      discountProductsResponse = discountProductsResponseFromJson(res);
      box.write("discount", res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  loadMoreData() async {
    isLoadingMoreData(true);
    if (discountProductsResponse!.nextPageUrl != null) {
      page++;
      final res = discountProductsResponseFromJson(
          await ProductServices.getAllDiscountProducts(
        page: page,
      ));
      discountProductsResponse!.nextPageUrl = res.nextPageUrl;
      if (res.data!.isNotEmpty) {
        discountProductsResponse!.data!.addAll(res.data!.toList());
      }
    } else {
      Get.closeAllSnackbars();

      Get.snackbar("products".tr, "no_more_products".tr);
    }
    isLoadingMoreData(false);
    update();
    isLoadingMoreData(true);
    await Future.delayed(const Duration(seconds: 1));
    isLoadingMoreData(false);
  }
}
