import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


import '../constants/urls.dart';
import '../models/general_api_response_model.dart';
import '../models/payment_intent_model.dart';
import '../models/payment_response_model.dart';

class PaymentServices {
  static Future<PaymentIntentResponse> createPaymentintent({
    required amount,
    required token,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(Urls.ordersCreatePaymentIntentUrl));
    request.fields.addAll({
      'amount': "$amount",
    });
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("createPaymentintent url ${Urls.ordersCreatePaymentIntentUrl}");
      print("createPaymentintent response $body");
    }
    return paymentIntentResponseFromJson(body);
  }

  static Future<OrdersPaymentResponse> ordersPayment({
    required Map<String, String> params,
    required token,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.ordersPaymentUrl),
    );
    request.fields.addAll(params);
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("ordersPayment url ${Urls.ordersPaymentUrl}");
      print("ordersPayment response $body");
    }
    return ordersPaymentResponseFromJson(body);
  }

  static Future<GeneralApiResponse> ordersPaypal({
    required Map<String, String> params,
    required token,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.ordersPaypalUrl),
    );
    request.fields.addAll(params);
    var headers = {'Authorization': 'Bearer $token'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();
    if (kDebugMode) {
      print("ordersPaypal url ${Urls.ordersPaypalUrl}");
      print("ordersPaypal response $body");
    }
    return generalApiResponseFromJson(body);
  }
}
