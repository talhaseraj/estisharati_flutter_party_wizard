// To parse this JSON data, do
//
//     final ordersPaymentResponse = ordersPaymentResponseFromJson(jsonString);

import 'dart:convert';

OrdersPaymentResponse ordersPaymentResponseFromJson(String str) =>
    OrdersPaymentResponse.fromJson(json.decode(str));

class OrdersPaymentResponse {
  int? status;
  String? message;
  Data? data;

  OrdersPaymentResponse({
    this.status,
    this.message,
    this.data,
  });

  factory OrdersPaymentResponse.fromJson(Map<String, dynamic> json) =>
      OrdersPaymentResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String? orderNumber;

  Data({
    this.orderNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderNumber: json["order_number"],
      );
}
