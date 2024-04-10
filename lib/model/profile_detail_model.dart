// To parse this JSON data, do
//
//     final profileDetailsModel = profileDetailsModelFromJson(jsonString);

import 'dart:convert';

ProfileDetailsModel profileDetailsModelFromJson(String str) => ProfileDetailsModel.fromJson(json.decode(str));

String profileDetailsModelToJson(ProfileDetailsModel data) => json.encode(data.toJson());

class ProfileDetailsModel {
    final String? username;
    final String? email;
    final String? phone;
    final String? address;
    final String? image;

    ProfileDetailsModel({
        this.username,
        this.email,
        this.phone,
        this.address,
        this.image,
    });

    factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) => ProfileDetailsModel(
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
        "image": image,
    };
}
