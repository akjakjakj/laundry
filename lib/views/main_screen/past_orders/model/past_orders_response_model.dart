import 'order_details_model.dart';

class PastOrdersResponse {
  bool? status;
  List<Orders>? orders;
  String? message;

  PastOrdersResponse({this.status, this.orders, this.message});

  PastOrdersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Orders {
  int? id;
  String? orderNumber;
  String? category;
  String? product;
  int? quantity;
  String? date;
  List<Details>? details;
  List<String>? productsName;
  String? branch;
  dynamic address;
  String? orderDate;
  String? createdDate;
  String? pickupDate;
  String? pickUpTimeSlot;
  String? customer;
  String? orderStatus;

  Orders(
      {this.id,
      this.orderNumber,
      this.category,
      this.product,
      this.quantity,
      this.date,
      this.details,
      this.productsName,
      this.pickUpTimeSlot,
      this.orderDate,
      this.pickupDate,
      this.createdDate,
      this.address,
      this.branch,
      this.customer,
      this.orderStatus});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    category = json['category'];
    product = json['product'];
    quantity = json['quantity'];
    date = json['date'];
    customer = json['customer'];
    branch = json['branch'];
    address = json['address'];
    orderDate = json['order_date'];
    createdDate = json['created_date'];
    pickupDate = json['pickup_date'];
    pickUpTimeSlot = json['pickup_time_slot'];
    orderStatus = json['order_status'];
    if (json['details'] != null) {
      details = <Details>[];
      productsName = [];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
        productsName!.add(v['product']);
      });
    }
  }
}
