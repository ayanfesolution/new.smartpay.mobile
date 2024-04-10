// To parse this JSON data, do
//
//     final getEmailTokenModel = getEmailTokenModelFromJson(jsonString);

import 'dart:convert';

GetEmailTokenModel getEmailTokenModelFromJson(String str) => GetEmailTokenModel.fromJson(json.decode(str));

String getEmailTokenModelToJson(GetEmailTokenModel data) => json.encode(data.toJson());

class GetEmailTokenModel {
    GetEmailTokenModel({
        this.token,
    });

    String? token;

    factory GetEmailTokenModel.fromJson(Map<String, dynamic> json) => GetEmailTokenModel(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
