/// 首页Banner模型
class BannerModel {
  int code;
  List<Banners> banners;

  BannerModel({this.code, this.banners});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    int code = json['code'];
    List<Banners> banners;
    if (json['banners'] != null) {
      banners = new List<Banners>();
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    return BannerModel(
      code: code,
      banners: banners,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


/// 轮播图
class Banners {
  int id;
  String image;
  String url;
  String fillColor;

  Banners({this.id, this.image, this.url, this.fillColor});

  factory Banners.fromJson(Map<String, dynamic> json) {
    return Banners(
      id: json['id'],
      image: json['image'],
      url: json['url'],
      fillColor: json['fillColor'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['url'] = this.url;
    data['fillColor'] = this.fillColor;
    return data;
  }
}
