// To parse this JSON data, do
//
//     final googleSigninResponse = googleSigninResponseFromJson(jsonString);

import 'dart:convert';

GoogleSigninResponse googleSigninResponseFromJson(String str) =>
    GoogleSigninResponse.fromJson(json.decode(str));

class GoogleSigninResponse {
  int? status;
  User? user;

  GoogleSigninResponse({
    this.status,
    this.user,
  });

  factory GoogleSigninResponse.fromJson(Map<String, dynamic> json) =>
      GoogleSigninResponse(
        status: json["status"],
        user: User.fromJson(json["user"]),
      );
}

class User {
  int? id;
  String? name;
  String? email;
  String? googleId;
  String? accessToken;
  int? expiredDays;
  bool? googleLogin;

  User({
    this.id,
    this.name,
    this.email,
    this.googleId,
    this.accessToken,
    this.expiredDays,
    this.googleLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        googleId: json["google_id"],
        accessToken: json["access_token"],
        expiredDays: json["expired_days"],
        googleLogin: json["google_login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "google_id": googleId,
        "access_token": accessToken,
        "expired_days": expiredDays,
        "google_login": googleLogin,
      };
}
