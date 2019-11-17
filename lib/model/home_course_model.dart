/// 首页课程模型
class HomeCourseModel {
  int code;
  List<Recommend> recommend;
  List<Newest> newest;
  List<Discount> discount;

  HomeCourseModel({this.code, this.recommend, this.newest, this.discount});

  factory HomeCourseModel.fromJson(Map<String, dynamic> json) {
    int code = json['code'];
    List<Recommend> recommend;
    List<Newest> newest;
    List<Discount> discount;
    if (json['recommend'] != null) {
      recommend = new List<Recommend>();
      json['recommend'].forEach((v) {
        recommend.add(new Recommend.fromJson(v));
      });
    }
    if (json['newest'] != null) {
      newest = new List<Newest>();
      json['newest'].forEach((v) {
        newest.add(new Newest.fromJson(v));
      });
    }
    if (json['discount'] != null) {
      discount = new List<Discount>();
      json['discount'].forEach((v) {
        discount.add(new Discount.fromJson(v));
      });
    }
    return HomeCourseModel(
      code: code,
      recommend: recommend,
      newest: newest,
      discount: discount,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.recommend != null) {
      data['recommend'] = this.recommend.map((v) => v.toJson()).toList();
    }
    if (this.newest != null) {
      data['newest'] = this.newest.map((v) => v.toJson()).toList();
    }
    if (this.discount != null) {
      data['discount'] = this.discount.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// 推荐课程
class Recommend {
  int courseID;
  String courseName;
  int price;
  String courseDescription;
  int applyCount;
  String courseImage;

  Recommend({
    this.courseID,
    this.courseName,
    this.price,
    this.courseDescription,
    this.applyCount,
    this.courseImage,
  });

  factory Recommend.fromJson(Map<String, dynamic> json) {
    return Recommend(
      courseID: json['courseID'],
      courseName: json['courseName'],
      price: json['price'],
      courseDescription: json['courseDescription'],
      applyCount: json['applyCount'],
      courseImage: json['courseImage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['price'] = this.price;
    data['courseDescription'] = this.courseDescription;
    data['applyCount'] = this.applyCount;
    data['courseImage'] = this.courseImage;
    return data;
  }
}

/// 最新课程
class Newest {
  int courseID;
  String courseName;
  int price;
  int applyCount;
  String courseImage;
  int favorableRate;
  String courseDescription;
  String createdAt;

  Newest({
    this.courseID,
    this.courseName,
    this.price,
    this.applyCount,
    this.courseImage,
    this.favorableRate,
    this.courseDescription,
    this.createdAt,
  });

  factory Newest.fromJson(Map<String, dynamic> json) {
    return Newest(
      courseID: json['courseID'],
      courseName: json['courseName'],
      price: json['price'],
      applyCount: json['applyCount'],
      courseImage: json['courseImage'],
      favorableRate: json['favorableRate'],
      courseDescription: json['courseDescription'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['price'] = this.price;
    data['applyCount'] = this.applyCount;
    data['courseImage'] = this.courseImage;
    data['favorableRate'] = this.favorableRate;
    data['courseDescription'] = this.courseDescription;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

/// 打折课程
class Discount {
  int courseID;
  String courseName;
  String courseImage;
  int applyCount;
  int price;
  int discount;
  String discountTime;

  Discount({
    this.courseID,
    this.courseName,
    this.courseImage,
    this.applyCount,
    this.price,
    this.discount,
    this.discountTime,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      courseID: json['courseID'],
      courseName: json['courseName'],
      courseImage: json['courseImage'],
      applyCount: json['applyCount'],
      price: json['price'],
      discount: json['discount'],
      discountTime: json['discountTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseID'] = this.courseID;
    data['courseName'] = this.courseName;
    data['courseImage'] = this.courseImage;
    data['applyCount'] = this.applyCount;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountTime'] = this.discountTime;
    return data;
  }
}
