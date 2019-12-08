import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/utils/http_util.dart';

class CourseDao {
  static Future<List<CourseSystemModel>> getSystemType() async {
    final response = await HttpUtil.request('/course/list/system-type');
    return CourseSystemTypeModel.fromJson(response).data;
  }

  static Future<List<CourseModel>> getCourse() async {
    final response = await HttpUtil.request('/course/list');
    return CourseListModel.fromJson(response).course;
  }
}
