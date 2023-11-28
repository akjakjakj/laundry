class CategoriesResponseModel {
  bool? status;
  List<Categories>? categories;
  String? message;

  CategoriesResponseModel({this.status, this.categories, this.message});

  CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Categories {
  int? id;
  String? name;
  String? icon;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }
}
