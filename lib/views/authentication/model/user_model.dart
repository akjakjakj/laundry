class UserData {
  bool? status;
  User? user;
  String? message;
  String? token;

  UserData({this.status, this.user, this.message, this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
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
