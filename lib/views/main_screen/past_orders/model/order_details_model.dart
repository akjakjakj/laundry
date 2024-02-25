class OrderDetailsModel {
  bool? status;
  Order? order;
  String? message;

  OrderDetailsModel({this.status, this.order, this.message});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    message = json['message'];
  }
}

class Order {
  int? id;
  String? orderNumber;
  int? serviceId;
  String? customer;
  String? serviceType;
  String? orderedAt;
  String? pickupAt;
  String? expectedDeliveryDate;
  String? orderStatus;
  String? totalCost;
  String? specialInstructions;
  String? createdAt;
  String? updatedAt;
  List<Details>? details;
  Order(
      {this.id,
      this.orderNumber,
      this.serviceId,
      this.serviceType,
      this.orderedAt,
      this.pickupAt,
      this.expectedDeliveryDate,
      this.orderStatus,
      this.totalCost,
      this.specialInstructions,
      this.createdAt,
      this.updatedAt,
      this.customer,
      this.details});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    serviceId = json['service_id'];
    serviceType = json['service_type'];
    orderedAt = json['ordered_at'];
    pickupAt = json['pickup_at'];
    expectedDeliveryDate = json['expected_delivery_date'];
    orderStatus = json['order_status'];
    totalCost = json['total_cost'];
    specialInstructions = json['special_instructions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }
}

class Details {
  int? id;
  String? category;
  String? product;
  String? rate;
  int? quantity;
  String? amount;

  Details(
      {this.id,
      this.category,
      this.product,
      this.rate,
      this.quantity,
      this.amount});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    product = json['product'];
    rate = json['rate'];
    quantity = json['quantity'];
    amount = json['amount'];
  }
}