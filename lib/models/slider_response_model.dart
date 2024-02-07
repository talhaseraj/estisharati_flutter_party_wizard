// To parse this JSON data, do
//
//     final sliderResponse = sliderResponseFromJson(jsonString);

import 'dart:convert';

SliderResponse sliderResponseFromJson(String str) => SliderResponse.fromJson(json.decode(str));


class SliderResponse {
    int? status;
    String? success;
    List<Datum>? data;

    SliderResponse({
        this.status,
        this.success,
        this.data,
    });

    factory SliderResponse.fromJson(Map<String, dynamic> json) => SliderResponse(
        status: json["status"],
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );


}

class Datum {
    int? id;
    String? productId;
    String? title;
    String? price;
    String? discount;
    dynamic discountPrice;
    String? categoryId;
    String? currency;
    String? photo;
    List<String>? images;
    List<Category>? category;

    Datum({
        this.id,
        this.productId,
        this.title,
        this.price,
        this.discount,
        this.discountPrice,
        this.categoryId,
        this.currency,
        this.photo,
        this.images,
        this.category,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        title: json["title"],
        price: json["price"],
        discount: json["discount"],
        discountPrice: json["discount_price"],
        categoryId: json["category_id"],
        currency: json["currency"],
        photo: json["photo"],
        images: List<String>.from(json["images"].map((x) => x)),
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    );


}

class Category {
    int? id;
    String ? title;
    String? photo;

    Category({
        this.id,
        this.title,
        this.photo,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "photo": photo,
    };
}
