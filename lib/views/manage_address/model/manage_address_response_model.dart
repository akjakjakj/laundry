class ManageAddressResponse {
  bool? status;
  List<Addresses>? addresses;
  String? message;

  ManageAddressResponse({this.status, this.addresses, this.message});

  ManageAddressResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Addresses {
  int? id;
  int? customerId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? country;
  String? postalCode;
  String? latitude;
  String? longitude;
  String? createdAt;
  String? updatedAt;

  Addresses(
      {this.id,
      this.customerId,
      this.name,
      this.address,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
