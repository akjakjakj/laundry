class ServicesResponseModel {
  bool? status;
  List<Services>? services;
  String? message;

  ServicesResponseModel({this.status, this.services, this.message});

  ServicesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Services {
  int? id;
  String? name;
  String? price;
  String? icon;

  Services({this.id, this.name, this.price, this.icon});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    icon = json['icon'];
  }
}
