import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../constants/storeage_constants.dart';
import '../constants/urls.dart';
import '../models/add_order_response_model.dart';
import '../models/cart_details_response_model.dart';
import '../models/order_summary_response_model.dart';
import '../models/user_profile_response_model.dart';
import '../screens/checkout_screen.dart';
import '../services/product_services.dart';
import '../utils/helpers.dart';
import 'package:flutter/material.dart';

class CartScreenController extends GetxController {
  final isLoading = true.obs,
      noInternet = false.obs,
      increment = false.obs,
      decrement = false.obs,
      addingOrder = false.obs,
      isBgUpdating = false.obs,
      box = GetStorage(),
      checkOutFormKey = GlobalKey<FormState>();

  CartDetailsResponse? cartDetailsResponse;
  OrderSummaryResponse? orderSummaryResponse;
  AddOrderResponse? addOrderResponse;

  final firstNameController = TextEditingController();
  //final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final shippingAddressController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  //final nearbyLandamrkController = TextEditingController();

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
    await getCartDetails(true);
    await getOrderSummary(true);

    isLoading(false);
    updateData(showShimmer: false);

    try {
      final userProfile =
          userProfileResponseFromJson(box.read(StorageConstants.userProfile));
      phoneNumberController.text = userProfile.data!.first.phone ?? "";
    } catch (e) {}
  }

  Future<void> updateData({required bool showShimmer}) async {
    if (showShimmer) {
      isLoading(true);
    } else {
      isBgUpdating(true);
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

    await getCartDetails(false);
    await getOrderSummary(false);

    isLoading(false);
    isBgUpdating(false);
    update();

    return;
  }

  Future getCartDetails(isInit) async {
    if (isInit) {
      try {
        cartDetailsResponse = cartDetailsResponseFromJson(
            box.read(Urls.productCartDetailsUrl).toString());
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res =
          await ProductServices.getCart(token: box.read(Constants.accessToken));
      cartDetailsResponse = cartDetailsResponseFromJson(res);
      box.write(Urls.productCartDetailsUrl, res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  Future getOrderSummary(isInit) async {
    if (isInit) {
      try {
        orderSummaryResponse = orderSummaryResponseFromJson(
            box.read(Urls.ordersSummaryUrl).toString());
        return;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    try {
      final res = await ProductServices.getOrderSummary(
          token: box.read(Constants.accessToken));
      orderSummaryResponse = orderSummaryResponseFromJson(res);
      box.write(Urls.ordersSummaryUrl, res);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return;
  }

  removeFromCartProduct(productId) async {
    try {
      final res = await ProductServices.removeFromCart(
          productId: productId, token: box.read(Constants.accessToken));
      if (res.status == 200) {
        Get.snackbar("product".tr, "removed_from_cart_successfully".tr);
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }

    updateData(showShimmer: false);
  }

  payNow(context) async {
    if (!checkOutFormKey.currentState!.validate()) {
      return;
    }
    if (addingOrder.value) {
      return;
    }
    addingOrder(true);

    try {
      final requestBody = {
        "first_name": firstNameController.text,
        //  "last_name": lastNameController.text,
        "address1": shippingAddressController.text,
        // "address2": nearbyLandamrkController.text,
        "phone": phoneNumberController.text,
        "country": countryController.text,
        "city": cityController.text,
      };

      addOrderResponse = await ProductServices.addOrder(
          token: box.read(Constants.accessToken), requestBody: requestBody);

      if (addOrderResponse!.status == 200) {
        checkOutFormKey.currentState!.reset();

        Get.off(() => SelectPaymentMethod(
              amount: int.parse(
                orderSummaryResponse!.data!.total!
                    .replaceAll(".", "")
                    .toString(),
              ),
              orderId: addOrderResponse!.data!.order!.id.toString(),
            ));
        updateData(showShimmer: true);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    addingOrder(false);
  }
}
