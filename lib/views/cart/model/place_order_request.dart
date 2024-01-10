class PlaceOrderRequest {
  int? serviceId;
  String? serviceType;
  int? addressId;
  String? pickupAt;
  String? deliveryAt;
  String? comments;
  String? image;
  List<Details>? details;

  PlaceOrderRequest(
      {this.serviceId,
      this.serviceType,
      this.addressId,
      this.pickupAt,
      this.deliveryAt,
      this.comments,
      this.image,
      this.details});

  PlaceOrderRequest.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceType = json['service_type'];
    addressId = json['address_id'];
    pickupAt = json['pickup_at'];
    deliveryAt = json['delivery_at'];
    comments = json['comments'];
    image = json['image'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
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
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  int? customerId;
  int? categoryId;
  int? productId;
  String? rate;
  int? quantity;
  String? amount;
  String? createdAt;
  String? updatedAt;

  Details(
      {this.id,
      this.customerId,
      this.categoryId,
      this.productId,
      this.rate,
      this.quantity,
      this.amount,
      this.createdAt,
      this.updatedAt});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    categoryId = json['category_id'];
    productId = json['product_id'];
    rate = json['rate'];
    quantity = json['quantity'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['category_id'] = categoryId;
    data['product_id'] = productId;
    data['rate'] = rate;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
