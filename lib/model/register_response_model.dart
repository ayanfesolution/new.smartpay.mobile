// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    RegisterModel({
        this.user,
        this.token,
    });

    User? user;
    String? token;

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
    };
}

class User {
    User({
        this.fullName,
        this.username,
        this.email,
        this.country,
        this.id,
    });

    String? fullName;
    String? username;
    String? email;
    String? country;
    String? id;

    factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        country: json["country"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "username": username,
        "email": email,
        "country": country,
        "id": id,
    };
}
