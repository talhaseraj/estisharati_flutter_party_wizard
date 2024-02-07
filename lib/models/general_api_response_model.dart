// To parse this JSON data, do
//
//     final generalApiResponse = generalApiResponseFromJson(jsonString);

import 'dart:convert';

GeneralApiResponse generalApiResponseFromJson(String str) => GeneralApiResponse.fromJson(json.decode(str));

String generalApiResponseToJson(GeneralApiResponse data) => json.encode(data.toJson());

class GeneralApiResponse {
    int? status;
    String? success;

    GeneralApiResponse({
        this.status,
        this.success,
    });

    factory GeneralApiResponse.fromJson(Map<String, dynamic> json) => GeneralApiResponse(
        status: json["status"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
    };
}
