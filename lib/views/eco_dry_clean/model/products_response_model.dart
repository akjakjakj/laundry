class ProductsResponseModel {
  bool? status;
  List<Products>? products;
  String? message;

  ProductsResponseModel({this.status, this.products, this.message});

  ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Products {
  int? id;
  String? name;
  int? categoryId;
  String? category;
  String? image;
  String? rate;
  int? quantity;
  bool? isAdded;

  Products(
      {this.id,
      this.name,
      this.categoryId,
      this.category,
      this.image,
      this.rate,
      this.quantity = 0,
      this.isAdded = false});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    category = json['category'];
    image = json['image'];
    rate = json['rate'];
  }
}

class PriceListResponse {
  bool? status;
  List<PriceList>? priceList;
  String? message;

  PriceListResponse({this.status, this.priceList, this.message});

  PriceListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['price_list'] != null) {
      priceList = <PriceList>[];
      json['price_list'].forEach((v) {
        priceList!.add(PriceList.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class PriceList {
  String? designer;
  String? ecoFriendly;

  PriceList({this.designer, this.ecoFriendly});

  PriceList.fromJson(Map<String, dynamic> json) {
    designer = json['designer'];
    ecoFriendly = json['eco-friendly'];
  }
}
