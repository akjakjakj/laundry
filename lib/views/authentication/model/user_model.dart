class UserData {
  bool? status;
  User? user;
  String? message;
  String? token;

  UserData({this.status, this.user, this.message, this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    message = json['message'];
    token = json['token'];
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? deviceToken;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.deviceToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    country = json['country'];
    deviceToken = json['device_token'];
  }
}

class PosUserData {
  Metadata? metadata;
  Data? data;

  PosUserData({this.metadata, this.data});

  PosUserData.fromJson(Map<String, dynamic> json) {
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Metadata {
  String? apiIdentifier;
  int? status;
  String? message;

  Metadata({this.apiIdentifier, this.status, this.message});

  Metadata.fromJson(Map<String, dynamic> json) {
    apiIdentifier = json['api_identifier'];
    status = json['status'];
    message = json['message'];
  }
}

class Data {
  String? accessToken;

  Data({this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }
}

class AppFunction {
  bool? flag;
  String? message;

  AppFunction.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    message = json['message'];
  }
}