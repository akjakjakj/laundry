// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  bool? status;
  List<Cart>? cart;
  String? message;
  var total;

  CartModel({this.status, this.cart, this.message, this.total});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      status: json["status"],
      cart: json["cart"] == null
          ? []
          : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
      message: json["message"],
      total: json['total']);

  Map<String, dynamic> toJson() => {
        "status": status,
        "cart": cart == null
            ? []
            : List<dynamic>.from(cart!.map((x) => x.toJson())),
        "message": message,
      };
}

class Cart {
  int? id;
  int? customerId;
  Category? service;
  Category? category;
  Product? product;
  int? quantity;
  int? rate;
  int? amount;

  Cart({
    this.id,
    this.customerId,
    this.service,
    this.category,
    this.product,
    this.quantity,
    this.rate,
    this.amount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        customerId: json["customer_id"],
        service:
            json["service"] == null ? null : Category.fromJson(json["service"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"],
        rate: json["rate"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "service": service?.toJson(),
        "category": category?.toJson(),
        "product": product?.toJson(),
        "quantity": quantity,
        "rate": rate,
        "amount": amount,
      };
}

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Product {
  int? id;
  String? name;
  String? image;

  Product({
    this.id,
    this.name,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
