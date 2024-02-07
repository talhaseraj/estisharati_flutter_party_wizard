// To parse this JSON data, do
//
//     final addOrderResponse = addOrderResponseFromJson(jsonString);

import 'dart:convert';

AddOrderResponse addOrderResponseFromJson(String str) =>
    AddOrderResponse.fromJson(json.decode(str));

class AddOrderResponse {
  int? status;
  String? success;
  Data? data;

  AddOrderResponse({
    this.status,
    this.success,
    this.data,
  });

  factory AddOrderResponse.fromJson(Map<String, dynamic> json) =>
      AddOrderResponse(
        status: json["status"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Order? order;
  List<Cart>? carts;

  Data({
    this.order,
    this.carts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order: Order.fromJson(json["order"]),
        carts: List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
      );
}

class Cart {
  int? id;
  String? productId;
  String? orderId;
  String? userId;
  String? price;
  String? status;
  String? quantity;
  String? amount;
  Product? product;

  Cart({
    this.id,
    this.productId,
    this.orderId,
    this.userId,
    this.price,
    this.status,
    this.quantity,
    this.amount,
    this.product,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        productId: json["product_id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        price: json["price"],
        status: json["status"],
        quantity: json["quantity"],
        amount: json["amount"],
        product: Product.fromJson(json["product"]),
      );
}

class Product {
  int? id;
  String? title;
  String? photo;
  List<String>? images;

  Product({
    this.id,
    this.title,
    this.photo,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        photo: json["photo"],
        images: List<String>.from(json["images"].map((x) => x)),
      );
}

class Order {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? phone;
  String? country;
  String? orderNumber;
  int? userId;
  String? email;
  dynamic shippingId;
  String? subTotal;
  String? quantity;
  dynamic totalAmount;
  String? status;
  String? paymentMethod;
  String? paymentStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Order({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.phone,
    this.country,
    this.orderNumber,
    this.userId,
    this.email,
    this.shippingId,
    this.subTotal,
    this.quantity,
    this.totalAmount,
    this.status,
    this.paymentMethod,
    this.paymentStatus,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        firstName: json["first_name"],
        lastName: json["last_name"],
        address1: json["address1"],
        address2: json["address2"],
        phone: json["phone"],
        country: json["country"],
        orderNumber: json["order_number"],
        userId: json["user_id"],
        email: json["email"],
        shippingId: json["shipping_id"],
        subTotal: json["sub_total"],
        quantity: json["quantity"],
        totalAmount: json["total_amount"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );
}
