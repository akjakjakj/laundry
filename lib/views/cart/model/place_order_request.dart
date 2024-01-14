class PlaceOrderRequest {
  int? serviceId;
  String? serviceType;
  int? addressId;
  String? pickupAt;
  String? deliveryAt;
  String? comments;
  List<dynamic>? image;

  PlaceOrderRequest(
      {this.serviceId,
      this.serviceType,
      this.addressId,
      this.pickupAt,
      this.deliveryAt,
      this.comments,
      this.image});

  PlaceOrderRequest.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceType = json['service_type'];
    addressId = json['address_id'];
    pickupAt = json['pickup_at'];
    deliveryAt = json['delivery_at'];
    comments = json['comments'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['service_type'] = serviceType;
    data['address_id'] = addressId;
    data['pickup_at'] = pickupAt;
    data['delivery_at'] = deliveryAt;
    data['comments'] = comments;
    data['image'] = image;
    return data;
  }
}
