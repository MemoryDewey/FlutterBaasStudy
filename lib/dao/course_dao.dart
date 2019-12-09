import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/utils/http_util.dart';

class CourseDao {
  static Future<List<CourseSystemModel>> getSystemType() async {
    final response = await HttpUtil.get('/course/list/system-type');
    return CourseSystemTypeModel.fromJson(response).data;
  }

  static Future<List<CourseModel>> getCourse(
      {Map<String, dynamic> data}) async {
    final response = await HttpUtil.get('/course/list', data: data);
    return CourseListModel.fromJson(response).course;
  }

  static Future<int> getCoursePage({Map<String, dynamic> data}) async {
    final response = await HttpUtil.post(
      '/course/list/page',
      data: data,
    );
    return CoursePageModel.fromJson(response).page;
  }
}
