// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

class UserProfileResponse {
  int? status;
  String? success;
  List<UserProfile>? data;

  UserProfileResponse({
    this.status,
    this.success,
    this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        status: json["status"],
        success: json["success"],
        data: List<UserProfile>.from(
            json["data"].map((x) => UserProfile.fromJson(x))),
      );
}

class UserProfile {
  int? id;
  String? name;
  String? email;
  String? phone;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
      };
}
