// To parse this JSON data, do
//
//     final reportCategoriesResponse = reportCategoriesResponseFromJson(jsonString);

import 'dart:convert';

ReportCategoriesResponse reportCategoriesResponseFromJson(String str) =>
    ReportCategoriesResponse.fromJson(json.decode(str));

class ReportCategoriesResponse {
  int? status;
  List<ReportCategory>? data;

  ReportCategoriesResponse({
    this.status,
    this.data,
  });

  factory ReportCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      ReportCategoriesResponse(
        status: json["status"],
        data: List<ReportCategory>.from(
            json["data"].map((x) => ReportCategory.fromJson(x))),
      );
}

class ReportCategory {
  int? id;
  String? titleEng;
  String? titleArb;
  DateTime? createdAt;
  String? updatedAt;

  ReportCategory({
    this.id,
    this.titleEng,
    this.titleArb,
    this.createdAt,
    this.updatedAt,
  });

  factory ReportCategory.fromJson(Map<String, dynamic> json) => ReportCategory(
        id: json["id"],
        titleEng: json["title_eng"],
        titleArb: json["title_arb"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );
}
