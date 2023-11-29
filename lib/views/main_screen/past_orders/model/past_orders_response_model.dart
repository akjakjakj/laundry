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

  Orders(
      {this.id,
      this.orderNumber,
      this.category,
      this.product,
      this.quantity,
      this.date});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    category = json['category'];
    product = json['product'];
    quantity = json['quantity'];
    date = json['date'];
  }
}
