import 'course_model.dart';

/// 首页课程模型
class HomeCourseModel {
  int code;
  List<CourseModel> recommend;
  List<CourseModel> newest;
  List<CourseModel> discount;

  HomeCourseModel({this.code, this.recommend, this.newest, this.discount});

  factory HomeCourseModel.fromJson(Map<String, dynamic> json) {
    int code = json['code'];
    List<CourseModel> recommend;
    List<CourseModel> newest;
    List<CourseModel> discount;
    if (json['recommend'] != null) {
      recommend = new List<CourseModel>();
      json['recommend'].forEach((v) {
        recommend.add(new CourseModel.fromJson(v));
      });
    }
    if (json['newest'] != null) {
      newest = new List<CourseModel>();
      json['newest'].forEach((v) {
        newest.add(new CourseModel.fromJson(v));
      });
    }
    if (json['discount'] != null) {
      discount = new List<CourseModel>();
      json['discount'].forEach((v) {
        discount.add(new CourseModel.fromJson(v));
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