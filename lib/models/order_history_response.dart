// To parse this JSON data, do
//
//     final orderHistoryResponse = orderHistoryResponseFromJson(jsonString);

import 'dart:convert';

OrderHistoryResponse orderHistoryResponseFromJson(String str) =>
    OrderHistoryResponse.fromJson(json.decode(str));

class OrderHistoryResponse {
  int? status;
  List<Datum>? data;

  OrderHistoryResponse({
    this.status,
    this.data,
  });

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) =>
      OrderHistoryResponse(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
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
  String? image;
  String? country;
  dynamic postCode;
  String? address1;
  String? address2;
  DateTime? deliveredDate;
  User? user;

  Datum({
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
    this.image,
    this.country,
    this.postCode,
    this.address1,
    this.address2,
    this.deliveredDate,
    this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        image: json["image"],
        country: json["country"],
        postCode: json["post_code"],
        address1: json["address1"],
        address2: json["address2"],
        deliveredDate: DateTime.parse(json["delivered_date"]),
        user: User.fromJson(json["user"]),
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
