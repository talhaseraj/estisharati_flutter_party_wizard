// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int? status;
  User? user;

  LoginResponse({
    this.status,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        user: json.containsKey("user") ? User.fromJson(json["user"]) : User(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user!.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? accessToken;
  int? expiredDays;
  bool? googleLogin;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.accessToken,
    this.expiredDays,
    this.googleLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        accessToken: json["access_token"],
        expiredDays: json["expired_days"],
        googleLogin: json["google_login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "access_token": accessToken,
        "expired_days": expiredDays,
        "google_login": googleLogin,
      };
}
