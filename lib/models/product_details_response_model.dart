// To parse this JSON data, do
//
//     final productDetailsResponse = productDetailsResponseFromJson(jsonString);

import 'dart:convert';

ProductDetailsResponse productDetailsResponseFromJson(String str) =>
    ProductDetailsResponse.fromJson(json.decode(str));

class ProductDetailsResponse {
  int? status;
  String? success;
  Data? data;

  ProductDetailsResponse({
    this.status,
    this.success,
    this.data,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        status: json["status"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int? id;

  dynamic discountPrice;
  String? photo,
      materialComposition,
      averageRating,
      totalReviews,
      summary,
      productWeight,
      gender,
      modelNumber,
      title,
      description,
      currency,
      price,
      color,
      purity;
  bool? isSaved;
  List<String>? images;

  Data({
    this.id,
    this.title,
    this.description,
    this.currency,
    this.price,
    this.materialComposition,
    this.summary,
    this.productWeight,
    this.gender,
    this.color,
    this.modelNumber,
    this.purity,
    this.discountPrice,
    this.photo,
    this.averageRating,
    this.totalReviews,
    this.isSaved,
    this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        currency: json["currency"],
        price: json["price"],
        materialComposition: json["material_composition"],
        discountPrice: json["discount_price"],
        productWeight: json["product_weight"],
        modelNumber: json["model_number"],
        summary: json["summary"],
        purity: json["purity"],
        color: json["color"],
        photo: json["photo"],
        gender: json["gender"],
        averageRating: json["average_rating"],
        totalReviews: json["total_reviews"],
        isSaved: json["is_saved"],
        images: List<String>.from(json["images"].map((x) => x)),
      );
}
