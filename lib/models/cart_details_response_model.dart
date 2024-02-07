// To parse this JSON data, do
//
//     final cartDetailsResponse = cartDetailsResponseFromJson(jsonString);

import 'dart:convert';

CartDetailsResponse cartDetailsResponseFromJson(String str) =>
    CartDetailsResponse.fromJson(json.decode(str));

class CartDetailsResponse {
  int? status;
  Data? data;

  CartDetailsResponse({
    this.status,
    this.data,
  });

  factory CartDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CartDetailsResponse(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String? currency;
  dynamic totalAmount;
  List<CartDetail>? cartDetails;

  Data({
    this.currency,
    this.totalAmount,
    this.cartDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currency: json["currency"],
        totalAmount: json["total_amount"],
        cartDetails: List<CartDetail>.from(
            json["cart_details"].map((x) => CartDetail.fromJson(x))),
      );
}

class CartDetail {
  int? id;
  String? productId;
  String? quantity;
  String? userId;
  String? unitPrice;
  String? totalPrice;
  String? discountPrice;
  String? title;
  String? photo;
  String? currency;
  List<String>? images;
  List<User>? user;

  CartDetail({
    this.id,
    this.productId,
    this.quantity,
    this.userId,
    this.unitPrice,
    this.totalPrice,
    this.discountPrice,
    this.title,
    this.photo,
    this.currency,
    this.images,
    this.user,
  });

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
        id: json["id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        userId: json["user_id"],
        unitPrice: json["unit_price"],
        totalPrice: json["total_price"],
        discountPrice: json["discount_price"],
        title: json["title"],
        photo: json["photo"],
        currency: json["currency"],
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
