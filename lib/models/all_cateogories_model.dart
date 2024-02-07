// To parse this JSON data, do
//
//     final allCategoriesResponse = allCategoriesResponseFromJson(jsonString);

import 'dart:convert';

AllCategoriesResponse allCategoriesResponseFromJson(String str) =>
    AllCategoriesResponse.fromJson(json.decode(str));

String allCategoriesResponseToJson(AllCategoriesResponse data) =>
    json.encode(data.toJson());

class AllCategoriesResponse {
  int? status;
  List<Datum>? data;

  AllCategoriesResponse({
    this.status,
    this.data,
  });

  factory AllCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      AllCategoriesResponse(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? categoryId;
  String? title, titleArb;
  String? imageUrl;

  Datum({
    this.categoryId,
    this.title,
    this.titleArb,
    this.imageUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["category_id"],
        title: json["title"],
        titleArb: json["titleArb"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "title": title,
        "image_url": imageUrl,
      };
}
