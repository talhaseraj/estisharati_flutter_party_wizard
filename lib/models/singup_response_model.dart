// To parse this JSON data, do
//
//     final signupResponse = signupResponseFromJson(jsonString);

import 'dart:convert';

SignupResponse signupResponseFromJson(String str) =>
    SignupResponse.fromJson(json.decode(str));

String signupResponseToJson(SignupResponse data) => json.encode(data.toJson());

class SignupResponse {
  int? status;
  String? message;
  Data? data;

  SignupResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        status: json["status"],
        message: json["message"],
        data: json.containsKey("data") ? Data.fromJson(json["data"]) : Data(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? accessToken;
  int? expiredDays;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.accessToken,
    this.expiredDays,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        accessToken: json["access_token"],
        expiredDays: json["expired_days"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "access_token": accessToken,
        "expired_days": expiredDays,
      };
}
