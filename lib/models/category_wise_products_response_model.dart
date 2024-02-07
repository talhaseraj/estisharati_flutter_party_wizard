// To parse this JSON data, do
//
//     final categoryWiseProductsResponse = categoryWiseProductsResponseFromJson(jsonString);

import 'dart:convert';

CategoryWiseProductsResponse categoryWiseProductsResponseFromJson(String str) =>
    CategoryWiseProductsResponse.fromJson(json.decode(str));

class CategoryWiseProductsResponse {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  CategoryWiseProductsResponse({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory CategoryWiseProductsResponse.fromJson(Map<String, dynamic> json) =>
      CategoryWiseProductsResponse(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class Datum {
  int? id;
  String? title;
  String? stock;
  String? price;
  String? discount;
  String? currency;
  String? discountPrice;
  String? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? images;

  Datum({
    this.id,
    this.title,
    this.stock,
    this.currency,
    this.price,
    this.discountPrice,
    this.discount,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        stock: json["stock"],
        price: json["price"],
        discountPrice: json["discount_price"],
        discount: json["discount"],
        currency: json["currency"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        images: List<String>.from(json["images"].map((x) => x)),
      );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
