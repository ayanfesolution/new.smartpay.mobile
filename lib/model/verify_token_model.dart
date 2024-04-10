

// To parse this JSON data, do
//
//     final verifyTokenModel = verifyTokenModelFromJson(jsonString);

import 'dart:convert';

VerifyTokenModel verifyTokenModelFromJson(String str) => VerifyTokenModel.fromJson(json.decode(str));

String verifyTokenModelToJson(VerifyTokenModel data) => json.encode(data.toJson());

class VerifyTokenModel {
    VerifyTokenModel({
        this.email,
    });

    String? email;

    factory VerifyTokenModel.fromJson(Map<String, dynamic> json) => VerifyTokenModel(
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}
