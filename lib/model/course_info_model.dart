import 'package:baas_study/model/profile_model.dart';

class CourseInfoDetailModel {
  int code;
  InfoDetailModel course;
  bool collection;

  CourseInfoDetailModel({this.code, this.course, this.collection});

  factory CourseInfoDetailModel.fromJson(Map<String, dynamic> json) {
    return CourseInfoDetailModel(
      code: json['code'],
      course: json['course'] != null
          ? InfoDetailModel.fromJson(json['course'])
          : null,
      collection: json['collection'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.course != null) {
      data['course'] = this.course.toJson();
    }
    data['collection'] = this.collection;
    return data;
  }
}

class InfoDetailModel {
  InfoModel info;
  DetailModel detail;

  InfoDetailModel({this.info, this.detail});

  factory InfoDetailModel.fromJson(Map<String, dynamic> json) {
    return InfoDetailModel(
      info: json['info'] != null ? new InfoModel.fromJson(json['info']) : null,
      detail: json['detail'] != null
          ? DetailModel.fromJson(json['detail'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    return data;
  }
}

class InfoModel {
  int id;
  String name;
  String description;
  String image;
  int price;
  int discount;
  String discountTime;
  String form;
  double rate;
  int apply;

  InfoModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.discount,
    this.discountTime,
    this.form,
    this.rate,
    this.apply,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      discount: json['discount'],
      discountTime: json['discountTime'],
      form: json['form'],
      rate: json['rate'] == 1
          ? 1.0
          : json['rate'] == 0 ? 0.0 : json['rate'],
      apply: json['apply'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discountTime'] = this.discountTime;
    data['form'] = this.form;
    data['rate'] = this.rate;
    data['apply'] = this.apply;
    return data;
  }
}

class DetailModel {
  String start;
  String finish;
  String detail;
  String cover;
  String arrange;
  String schedule;
  UserInfoModel teacher;

  DetailModel({
    this.start,
    this.finish,
    this.detail,
    this.cover,
    this.arrange,
    this.schedule,
    this.teacher,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      start: json['start'],
      finish: json['finish'],
      detail: json['detail'],
      cover: json['coverUrl'],
      arrange: json['arrange'],
      schedule: json['schedule'],
      teacher: json['teacher'] != null
          ? UserInfoModel.fromJson(json['teacher'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['finish'] = this.finish;
    data['detail'] = this.detail;
    data['coverUrl'] = this.cover;
    data['arrange'] = this.arrange;
    data['schedule'] = this.schedule;
    if (this.teacher != null) {
      data['teacher'] = this.teacher.toJson();
    }
    return data;
  }
}

class CourseApplyModel {
  int apply;
  int code;
  String msg;

  CourseApplyModel({this.apply, this.code, this.msg});

  factory CourseApplyModel.fromJson(Map<String, dynamic> json) {
    return CourseApplyModel(
      apply: json['apply'],
      code: json['code'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apply'] = this.apply;
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}
