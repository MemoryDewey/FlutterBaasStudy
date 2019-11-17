import 'dart:async';
import 'package:baas_study/model/home_course_model.dart';
import 'package:baas_study/utils/http_util.dart';

class HomeCourseDao {
  static Future<HomeCourseModel> fetch() async {
    final response = await HttpUtil.request('/course/list/m/home');
    return HomeCourseModel.fromJson(response);
  }
}
