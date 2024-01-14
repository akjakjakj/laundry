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

  Orders(
      {this.id,
      this.orderNumber,
      this.category,
      this.product,
      this.quantity,
      this.date,
      this.details,
      this.productsName});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    category = json['category'];
    product = json['product'];
    quantity = json['quantity'];
    date = json['date'];
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
