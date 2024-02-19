import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/urls.dart';
import '../models/add_order_response_model.dart';
import '../models/general_api_response_model.dart';

class ProductServices {
  static Future<String> getAllCategories() async {
    final response = await http.get(Uri.parse(Urls.categoryAllUrl));
    if (kDebugMode) {
      print("getAllCategories url ${Urls.categoryAllUrl}");
      print("getAllCategories response ${response.body}");
    }
    return response.body;
  }

  static Future<String> getBanner() async {
    final response = await http.get(Uri.parse(Urls.bannerUrl));
    if (kDebugMode) {
      print("getBanner url ${Urls.bannerUrl}");
      print("getBanner response ${response.body}");
    }
    return response.body;
  }

  static Future<String> getAllProducts({required sort, required page}) async {
    final response = await http
        .get(Uri.parse("${Urls.productsAllUrl}?sort=$sort&page=$page"));
    if (kDebugMode) {
      print("getAllProducts url ${Urls.productsAllUrl}?sort=$sort");
      print("getAllProducts response ${response.body}");
    }
    return response.body;
  }

  static Future<String> catergoryWiseProducts({
    required categoryId,
    required subCategoryId,
    required page,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Urls.categoryProductsUrl}?page=$page"));
    final params = {
      'category_id': "$categoryId",
      'subcategory_id': "$subCategoryId",
      // "sort": "$sort"
    };
    request.fields.addAll(params);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("catergoryWiseProducts url ${Urls.categoryProductsUrl}?page=$page");
      print("catergoryWiseProducts params $params");
      print("catergoryWiseProducts response $body");
    }
    return body;
  }

  static Future<String> getProductDetails(
      {required productId, required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.productDetailsUrl));
    request.fields.addAll({'product_id': productId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("getProductDetails url ${Urls.productDetailsUrl}");
      print("getProductDetails response $body");
    }
    return body;
  }

  static Future<GeneralApiResponse> saveProduct(
      {required productId, required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(Urls.productSaveUrl));
    request.fields.addAll({'product_id': productId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("saveProduct url ${Urls.productSaveUrl}");
      print("saveProduct response $body");
    }
    return generalApiResponseFromJson(body);
  }

  static Future<GeneralApiResponse> unSaveProduct(
      {required productId, required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.productUnSaveUrl));
    request.fields.addAll({'product_id': productId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("saveProduct url ${Urls.productSaveUrl}");
      print("saveProduct response $body");
    }
    return generalApiResponseFromJson(body);
  }

  static Future<String> getAllSavedProducts({required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    final response =
        await http.get(Uri.parse(Urls.productAllSavedUrl), headers: headers);
    if (kDebugMode) {
      print("getAllSavedProducts url ${Urls.productAllSavedUrl}");
      print("getAllSavedProducts response ${response.body}");
    }
    return response.body;
  }

  static Future<GeneralApiResponse> addToCart(
      {required productId,
      required quantity,
      required token,
      required isIncrement}) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.productAddToCartUrl));
    request.fields.addAll({
      'product_id': "$productId",
      'quantity': "$quantity",
      'is_increment': "$isIncrement"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("addToCart url ${Urls.productAddToCartUrl}");
      print("addToCart response $body");
    }
    return generalApiResponseFromJson(body);
  }

  static Future<String> getCart({required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    final response =
        await http.get(Uri.parse(Urls.productCartDetailsUrl), headers: headers);
    if (kDebugMode) {
      print("getCart url ${Urls.productCartDetailsUrl}");
      print("getCart response ${response.body}");
    }
    return response.body;
  }

  static Future<GeneralApiResponse> removeFromCart(
      {required productId, required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.productDeleteCartUrl));
    request.fields.addAll({
      'product_id': "$productId",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("removeFromCart url ${Urls.productDeleteCartUrl}");
      print("removeFromCart response $body");
    }
    return generalApiResponseFromJson(body);
  }

  static Future<String> categorySlider({
    required categoryId,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(Urls.sliderUrl));
    request.fields.addAll({
      'category_id': "$categoryId",
    });

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("categorySlider url ${Urls.bannerUrl}");
      print("categorySlider response $body");
    }
    return body;
  }

  static Future<String> getAllDiscountProducts({required page}) async {
    final response =
        await http.get(Uri.parse("${Urls.productDiscountUrl}?page=$page"));
    if (kDebugMode) {
      print("getAllDiscountProducts url ${Urls.productDiscountUrl}?page=$page");
      print("getAllDiscountProducts response ${response.body}");
    }
    return response.body;
  }

  static Future<String> getAllProductReviews(
      {required page, required productId}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Urls.productAllReviewsUrl}?page=$page"));
    request.fields.addAll({
      'product_id': "$productId",
    });

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("getAllProductReviews url ${Urls.productAllReviewsUrl}?page=$page");
      print("getAllProductReviews response $body");
    }
    return body;
  }

  static Future<GeneralApiResponse> addProductReview({
    required productId,
    required review,
    required selectedRate,
    required token,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.productAddReviewsUrl));
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    request.fields.addAll({
      'product_id': "$productId",
      'review': "$review",
      "rate": "$selectedRate"
    });
    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("addProductReview url ${Urls.productAddReviewsUrl}");
      print("addProductReview response $body");
    }
    return generalApiResponseFromJson(body);
  }

  static Future<AddOrderResponse> addOrder({
    required token,
    required Map<String, String> requestBody,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(Urls.ordersAddUrl));
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    request.fields.addAll(requestBody);
    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("addOrder url ${Urls.ordersAddUrl}");
      print("addOrder response $body");
    }
    return addOrderResponseFromJson(body);
  }

  static Future<String> getOrdersHistory({required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    final response =
        await http.get(Uri.parse(Urls.ordersHistoryUrl), headers: headers);
    if (kDebugMode) {
      print("getOrdersHistory url ${Urls.ordersHistoryUrl}");
      print("getOrdersHistory response ${response.body}");
    }
    return response.body;
  }

  static Future<String> getOrderSummary({required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    final response =
        await http.get(Uri.parse(Urls.ordersSummaryUrl), headers: headers);
    if (kDebugMode) {
      print("getOrderSummary url ${Urls.ordersSummaryUrl}");
      print("getOrderSummary response ${response.body}");
    }
    return response.body;
  }

  static Future<String> getOrderDetails({
    required orderId,
    required token,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.ordersDetailUrl));
    request.fields.addAll({
      'order_id': "$orderId",
    });
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("getOrderDetails url ${Urls.ordersDetailUrl}");
      print("getOrderDetails response $body");
    }
    return body;
  }

  static Future<String> getSubCategories(
      {required categoryId, required token}) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('POST', Uri.parse(Urls.subcategoriesUrl));
    request.fields.addAll({'category_id': categoryId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("getSubCategories url ${Urls.subcategoriesUrl}");
      print("getSubCategories response $body");
    }
    return body;
  }
}
