// To parse this JSON data, do
//
//     final orderSummaryResponse = orderSummaryResponseFromJson(jsonString);

import 'dart:convert';

OrderSummaryResponse orderSummaryResponseFromJson(String str) =>
    OrderSummaryResponse.fromJson(json.decode(str));

class OrderSummaryResponse {
  int? status;
  Data? data;

  OrderSummaryResponse({
    this.status,
    this.data,
  });

  factory OrderSummaryResponse.fromJson(Map<String, dynamic> json) =>
      OrderSummaryResponse(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int? id;
  String? userId;
  String? productId;
  String? vat;
  String? currency;
  String? subTotal;
  String? totalVat;
  String? shipping;
  String? total;
  List<String>? images;
  List<User>? user;

  Data({
    this.id,
    this.userId,
    this.productId,
    this.vat,
    this.currency,
    this.subTotal,
    this.totalVat,
    this.shipping,
    this.total,
    this.images,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        vat: json["vat"],
        currency: json["currency"],
        subTotal: json["sub_total"],
        totalVat: json["total_vat"],
        shipping: json["shipping"],
        total: json["total"],
        images: List<String>.from(json["images"].map((x) => x)),
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
      );
}

class User {
  int? id;
  String? name;

  User({
    this.id,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
