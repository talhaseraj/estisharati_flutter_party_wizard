import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../constants/urls.dart';
import '../models/saved_products_response_model.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';

class FavoriteScreenController extends GetxController {
  final isLoading = true.obs;
  final noInternet = false.obs;
  final isBgUpdate = false.obs;
  int page = 1;
  final box = GetStorage();
  SavedProductsResponse? savedProductsResponse;

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
    isBgUpdate(!showShimmer);

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
    await getAllSavedProducts(false);

    update();

    isLoading(false);
    isBgUpdate(false);
    return;
  }

  Future getAllSavedProducts(isInit) async {
    if (isInit) {
      try {
        savedProductsResponse = savedProductsResponseFromJson(
            box.read(Urls.productAllSavedUrl).toString());
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getAllSavedProducts(
          token: box.read(Constants.accessToken));
      savedProductsResponse = savedProductsResponseFromJson(res);
      box.write(Urls.productAllSavedUrl, res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  unSaveProduct(productId) async {
    try {
      final res = await ProductServices.unSaveProduct(
          productId: productId.toString(),
          token: box.read(Constants.accessToken));
      if (res.status == 200) {
        Get.snackbar("product".tr, "removed_from_favorite_successfully".tr);
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }

    updateData(showShimmer: false);
  }
}
