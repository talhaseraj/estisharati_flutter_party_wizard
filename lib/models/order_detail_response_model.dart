// To parse this JSON data, do
//
//     final orderDetailResponse = orderDetailResponseFromJson(jsonString);

import 'dart:convert';

OrderDetailResponse orderDetailResponseFromJson(String str) =>
    OrderDetailResponse.fromJson(json.decode(str));

class OrderDetailResponse {
  int? status;
  Data? data;

  OrderDetailResponse({
    this.status,
    this.data,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailResponse(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int? id;
  String? orderNumber;
  String? totalAmount;
  String? paymentMethod;
  String? paymentStatus;
  String? orderStatus;
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? currency;
  String? country;
  dynamic postCode;
  String? address1;
  String? address2;
  DateTime? deliveredDate;
  String? avatar;
  List<Product>? products;

  Data({
    this.id,
    this.orderNumber,
    this.totalAmount,
    this.paymentMethod,
    this.paymentStatus,
    this.orderStatus,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.country,
    this.currency,
    this.postCode,
    this.address1,
    this.address2,
    this.deliveredDate,
    this.avatar,
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        orderNumber: json["order_number"],
        totalAmount: json["total_amount"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        currency: json["currency"],
        country: json["country"],
        postCode: json["post_code"],
        address1: json["address1"],
        address2: json["address2"],
        deliveredDate: DateTime.parse(json["delivered_date"]),
        avatar: json["avatar"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );
}

class Product {
  int? id;
  String? title;
  String? description;
  String? currency;
  String? discountPrice;
  String? orderId;
  DateTime? deliveredDate;
  String? photo;
  List<String>? images;

  Product({
    this.id,
    this.title,
    this.description,
    this.currency,
    this.discountPrice,
    this.orderId,
    this.deliveredDate,
    this.photo,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        currency: json["currency"],
        discountPrice: json["discount_price"],
        orderId: json["order_id"],
        deliveredDate: DateTime.parse(json["delivered_date"]),
        photo: json["photo"],
        images: List<String>.from(json["images"].map((x) => x)),
      );
}
