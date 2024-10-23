class HomeBanners {
  bool? status;
  List<Banners>? banners;
  String? message;

  HomeBanners({this.status, this.banners, this.message});

  HomeBanners.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Banners {
  int? id;
  String? type;
  String? thumbnail;
  String? link;

  Banners({this.id, this.type, this.thumbnail, this.link});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    thumbnail = json['thumbnail'];
    link = json['link'];
  }
}

class BannersArguments {
  String link;
  BannersArguments({required this.link});
}
