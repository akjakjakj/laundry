// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    bool? status;
    User? user;
    String? message;

    ProfileModel({
        this.status,
        this.user,
        this.message,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "user": user?.toJson(),
        "message": message,
    };
}

class User {
    int? id;
    String? name;
    String? email;
    dynamic phone;
    dynamic deviceToken;
    dynamic profilePicture;

    User({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.deviceToken,
        this.profilePicture,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        deviceToken: json["device_token"],
        profilePicture: json["profile_picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "device_token": deviceToken,
        "profile_picture": profilePicture,
    };
}
