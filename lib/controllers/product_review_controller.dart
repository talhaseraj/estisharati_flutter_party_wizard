import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/product_reviews_response_model.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';

class ProductReviewController extends GetxController {
  final int productId;

  ProductReviewController({required this.productId});
  final isLoading = true.obs;
  final noInternet = false.obs;

  final selectedSortId = 0.obs;

  final isLoadingMoreData = false.obs;
  int page = 1;
  final box = GetStorage();

  ProductReviewsResponse? productReviewsResponse;

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

    await getAllProductReviews(true);
    isLoading(false);
    updateData(showShimmer: false);
  }

  Future<void> updateData({required bool showShimmer}) async {
    if (showShimmer) {
      isLoading(true);
    }
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

    await getAllProductReviews(false);

    update();

    isLoading(false);
    return;
  }

  Future getAllProductReviews(isInit) async {
    page = 1;
    if (isInit) {
      try {
        productReviewsResponse = productReviewsResponseFromJson(
            box.read("reviews$productId").toString());

        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getAllProductReviews(
          page: page, productId: productId);
      productReviewsResponse = productReviewsResponseFromJson(res);
      box.write("reviews$productId", res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  loadMoreData() async {
    isLoadingMoreData(true);
    if (productReviewsResponse!.nextPageUrl != null) {
      page++;
      final res = productReviewsResponseFromJson(
          await ProductServices.getAllProductReviews(
        productId: productId,
        page: page,
      ));
      productReviewsResponse!.nextPageUrl = res.nextPageUrl;
      if (res.data!.isNotEmpty) {
        productReviewsResponse!.data!.addAll(res.data!.toList());
      }
    } else {}
    isLoadingMoreData(false);
    update();
    isLoadingMoreData(true);
    await Future.delayed(const Duration(seconds: 1));
    isLoadingMoreData(false);
  }
}
