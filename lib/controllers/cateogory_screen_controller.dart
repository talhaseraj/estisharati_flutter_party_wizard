import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../constants/urls.dart';
import '../models/banner_response_model.dart';
import '../models/category_wise_products_response_model.dart';
import '../models/subcategory_response_model.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';

class CategoryScreenController extends GetxController {
  CategoryScreenController(this.categoryId);
  final isLoading = true.obs;
  final noInternet = false.obs;
  final isUpdating = false.obs;
  final isBgLoading = false.obs;
  final selectedSortId = 0.obs;
  final String categoryId;
  final selectedSubCategoryId = 0.obs;

  final isLoadingMoreData = false.obs;
  int page = 1;
  final box = GetStorage();
  final sortTypeList = ["all", "trending", "newest"];

  CategoryWiseProductsResponse? categoryWiseProductsResponse;
  SubCategoriesResponse? subCategoriesResponse;
  BannerResponse? bannerResponse;

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

    await getSlider(true);
    await getAllProducts(true);
    await getSubCategories(true);

    isLoading(false);
    updateData(showShimmer: false);
  }

  Future<void> updateData({required bool showShimmer}) async {
    isUpdating(showShimmer);
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

    await getAllProducts(false);
    await getSlider(false);
    await getSubCategories(false);
    update();
    isBgLoading(false);
    isUpdating(false);
    return;
  }

  Future getSlider(isInit) async {
    if (isInit) {
      try {
        bannerResponse =
            bannerResponseFromJson(box.read(Urls.bannerUrl).toString());

        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getBanner();
      bannerResponse = bannerResponseFromJson(res);
      box.write(Urls.bannerUrl, res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  Future getSubCategories(isInit) async {
    if (isInit) {
      try {
        subCategoriesResponse = subCategoriesResponseFromJson(
            box.read("subCategory$categoryId").toString());

        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getSubCategories(
          categoryId: categoryId, token: box.read(Constants.accessToken));
      subCategoriesResponse = subCategoriesResponseFromJson(res);
      box.write("subCategory$categoryId", res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  Future getAllProducts(isInit) async {
    page = 1;
    if (isInit) {
      try {
        categoryWiseProductsResponse = categoryWiseProductsResponseFromJson(
            box.read("category$categoryId").toString());

        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.catergoryWiseProducts(
          categoryId: categoryId,
          subCategoryId: selectedSubCategoryId.value == 0
              ? ""
              : selectedSubCategoryId.value,
          page: page,
          sort: sortTypeList[selectedSortId.value]);
      categoryWiseProductsResponse = categoryWiseProductsResponseFromJson(res);
      box.write("category$categoryId", res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  loadMoreData() async {
    isLoadingMoreData(true);
    if (categoryWiseProductsResponse!.nextPageUrl != null) {
      page++;
      final res = categoryWiseProductsResponseFromJson(
          await ProductServices.catergoryWiseProducts(
        subCategoryId: selectedSubCategoryId.value,
        categoryId: categoryId,
        sort: sortTypeList[selectedSortId.value],
        page: page,
      ));
      categoryWiseProductsResponse!.nextPageUrl = res.nextPageUrl;
      if (res.data!.isNotEmpty) {
        categoryWiseProductsResponse!.data!.addAll(res.data!.toList());
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
