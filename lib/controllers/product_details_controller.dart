import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

import '../models/product_details_response_model.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';
import 'package:flutter/material.dart';

class ProductDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final reiviewTextController = TextEditingController();
  late final TabController tabController;

  final box = GetStorage();

  final int productId;

  int selectedRate = 1;

  final noInternet = false.obs;

  final addingToCart = false.obs;

  final isAddingReview = false.obs;
  ProductDetailsController({required this.productId});

  ProductDetailsResponse? productDetailsResponse;

  var isLoading = true.obs;
  var isSaved = false.obs;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
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
    await getProductDetails(true);
    isLoading(false);
    updateData();
  }

  updateData() async {
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
    await getProductDetails(false);
    update();
  }

  Future getProductDetails(isInit) async {
    if (isInit) {
      try {
        productDetailsResponse = productDetailsResponseFromJson(
            box.read("productId$productId").toString());
        isSaved.value = productDetailsResponse!.data!.isSaved ?? false;
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getProductDetails(
          token: box.read(Constants.accessToken),
          productId: productId.toString());
      productDetailsResponse = productDetailsResponseFromJson(res);
      box.write("productId$productId", res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    isSaved.value = productDetailsResponse!.data!.isSaved ?? false;
    return;
  }

  saveUnsaveProduct() {
    final token = box.read(Constants.accessToken);
    if (!isSaved.value) {
      unSaveProduct(token);
    } else {
      saveProduct(token);
    }
  }

  saveProduct(token) async {
    try {
      final res = await ProductServices.saveProduct(
          productId: productId.toString(), token: token);
      if (res.status == 200) {
        Get.snackbar("product".tr, "added_to_favorite_successfully".tr);
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  unSaveProduct(token) async {
    try {
      final res = await ProductServices.unSaveProduct(
          productId: productId.toString(), token: token);
      if (res.status == 200) {
        Get.snackbar("product".tr, "removed_from_favorite_successfully".tr);
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future addToCart({required quantity, required productId}) async {
    if (addingToCart.value) {
      return;
    }
    addingToCart(true);
    try {
      final res = await ProductServices.addToCart(
          isIncrement: 1,
          quantity: quantity,
          productId: productId,
          token: box.read(
            Constants.accessToken,
          ));
      if (res.status == 200) {
        Get.snackbar("product".tr, "added_to_cart_successfully".tr);
      } else if (res.status == 401) {
        Get.snackbar("product".tr, "stock_not_sufficient".tr);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return;
    }
    addingToCart(false);
    return;
  }

  addReview(BuildContext context) async {
    isAddingReview(true);
    try {
      final res = await ProductServices.addProductReview(
        token: box.read(Constants.accessToken),
        productId: productId,
        review: reiviewTextController.text,
        selectedRate: selectedRate,
      );
      if (res.status == 200) {
        Get.snackbar("review".tr, "review_added".tr);
      }
    } catch (e) {}
    selectedRate = 1;
    reiviewTextController.clear();
    isAddingReview(false);
    Navigator.of(context).pop();
    updateData();
  }
}
