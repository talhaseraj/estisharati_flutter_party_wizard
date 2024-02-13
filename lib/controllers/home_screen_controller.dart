import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../constants/urls.dart';
import '../models/all_cateogories_model.dart';
import '../models/all_products_response_model.dart';
import '../models/banner_response_model.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';

class HomeScreenController extends GetxController {
  final BuildContext context;
  HomeScreenController(this.context);
  var isLoading = true.obs;
  var isLoadingMoreData = false.obs;
  var isUpdating = false.obs;
  var isBgUpdate = false.obs;

  final noInternet = false.obs;
  final box = GetStorage();
  var selectedSortId = 0.obs;

  final sortTypeList = ["all", "trending", "newest"];

  int page = 1;

  AllCategoriesResponse? allCategoriesResponse;
  BannerResponse? bannerResponse;
  AllProductsResponse? allProductsResponse;

  @override
  void onInit() {
    initializeData();
    checkUpdate();
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
    await getBanner(true);
    await getAllProducts(true);
    isLoading(false);
    updateData(showShimmer: false);
  }

  Future<void> updateData({required bool showShimmer}) async {
    if (showShimmer) {
      isUpdating(true);
    } else {
      isBgUpdate(true);
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
    await getAllCategories(false);
    await getBanner(false);
    await getAllProducts(false);
    update();

    isUpdating(false);
    isBgUpdate(false);

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

  Future getBanner(isInit) async {
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

  Future getAllProducts(isInit) async {
    page = 1;
    if (isInit) {
      try {
        allProductsResponse = allProductsResponseFromJson(
            box.read(Urls.productsAllUrl).toString());

        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getAllProducts(
          page: page, sort: sortTypeList[selectedSortId.value]);
      allProductsResponse = allProductsResponseFromJson(res);
      box.write(Urls.productsAllUrl, res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  loadMoreData() async {
    isLoadingMoreData(true);
    if (allProductsResponse!.nextPageUrl != null) {
      page++;
      final res =
          allProductsResponseFromJson(await ProductServices.getAllProducts(
        sort: sortTypeList[selectedSortId.value],
        page: page,
      ));
      allProductsResponse!.nextPageUrl = res.nextPageUrl;
      if (res.data!.isNotEmpty) {
        allProductsResponse!.data!.addAll(res.data!.toList());
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

  void checkUpdate() async {
    final newVersion = NewVersionPlus(
        androidId: "com.estisharati.partywizard",
        iOSId: "com.estisharati.partywizard",
        iOSAppStoreCountry: 'AE');
    final status = await newVersion.getVersionStatus();

    if (status!.canUpdate == true) {
      newVersion.showUpdateDialog(
        context: Get.context ?? context,
        versionStatus: status,
        allowDismissal: true,
        launchModeVersion: LaunchModeVersion.external,
        dialogTitle: "UPDATE",
        dialogText:
            "Please update the app from ${status.localVersion} to ${status.storeVersion}",
      );
    }
  }
}
