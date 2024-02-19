import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_wizard/models/all_cateogories_model.dart';

import '../constants/constants.dart';
import '../constants/urls.dart';
import '../models/banner_response_model.dart';
import '../models/category_wise_products_response_model.dart';
import '../models/subcategory_response_model.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';

class CategoryMenuScreenController extends GetxController {
  final isLoading = true.obs;
  final noInternet = false.obs;
  final isUpdating = false.obs;
  final isBgLoading = false.obs;
  final selectedSortId = 0.obs;

  final selectedSubCategoryId = 0.obs;

  final isLoadingMoreData = false.obs;
  int page = 1;
  final box = GetStorage();
  final sortTypeList = ["all", "trending", "newest"];

  AllCategoriesResponse? allCategoriesResponse;

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

    await getAllCategories(true);

    isLoading(false);
    updateData(showShimmer: false);
  }

  Future<void> updateData({required bool showShimmer}) async {
    isLoading(showShimmer);
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

    await getAllCategories(false);

    isBgLoading(false);
    isLoading(false);
    update();

    return;
  }

  Future getAllCategories(isInit) async {
    if (isInit) {
      try {
        allCategoriesResponse = allCategoriesResponseFromJson(
            box.read(Urls.categoryAllUrl).toString());
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getAllCategories();
      allCategoriesResponse = allCategoriesResponseFromJson(res);
      box.write(Urls.categoryAllUrl, res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }
}
