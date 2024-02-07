// To parse this JSON data, do
//
//     final productReviewsResponse = productReviewsResponseFromJson(jsonString);

import 'dart:convert';

ProductReviewsResponse productReviewsResponseFromJson(String str) => ProductReviewsResponse.fromJson(json.decode(str));


class ProductReviewsResponse {
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    ProductReviewsResponse({
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

    factory ProductReviewsResponse.fromJson(Map<String, dynamic> json) => ProductReviewsResponse(
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
    String? rate;
    String? review;
    String? userId;
    String? name;
    List<String>? images;

    Datum({
        this.id,
        this.title,
        this.rate,
        this.review,
        this.userId,
        this.name,
        this.images,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        rate: json["rate"],
        review: json["review"],
        userId: json["user_id"],
        name: json["name"],
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
