import 'package:baas_study/model/course_manage_model.dart';
import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/utils/http_util.dart';

class CourseDao {
  /// 获取课程体系及课程类别
  static Future<List<CourseSystemModel>> getSystemType() async {
    final response = await HttpUtil.get('/course/list/system-type');
    return CourseSystemTypeModel.fromJson(response).data;
  }

  /// 获取课程
  static Future<List<CourseModel>> getCourse(
      {Map<String, dynamic> data}) async {
    final response = await HttpUtil.get('/course/list', data: data);
    return CourseListModel.fromJson(response).course;
  }

  /// 获取课程页数（列表使用）
  static Future<CoursePageModel> getCoursePage(
      {Map<String, dynamic> data}) async {
    final response = await HttpUtil.post(
      '/course/list/page',
      data: data,
    );
    return CoursePageModel.fromJson(response);
  }

  /// 获取所有已报名的课程
  static Future<CourseManageModel> getUserCourse(int page) async {
    final response =
        await HttpUtil.get('/course/list/user-course', data: {"page": page});
    return CourseManageModel.fromJson(response, UserCoursesModel());
  }

  /// 获取课程币购买的课程
  static Future<CourseManageModel> getBalanceCourse(int page) async {
    final response = await HttpUtil.get(
      '/course/list/user-course-rmb',
      data: {"page": page},
    );
    return CourseManageModel.fromJson(response, BalanceCoursesModel());
  }

  /// 获取BST购买的课程
  static Future<CourseManageModel> getBstCourse(int page) async {
    final response = await HttpUtil.get(
      '/course/list/user-course-bst',
      data: {"page": page},
    );
    return CourseManageModel.fromJson(response, BstCoursesModel());
  }

  /// 取消报名免费课程
  static Future<ResponseNormalModel> cancelFreeCourse(int courseID) async {
    final response = await HttpUtil.get('/course/information/cancel-free',
        data: {"courseID": courseID});
    return ResponseNormalModel.fromJson(response);
  }

  /// 获取收藏的全部课程
  static Future<List<SimpleCoursesModel>> getAllCollections() async {
    final response = await HttpUtil.get('/course/list/collection-all');
    return CourseManageModel.fromJson(response, SimpleCoursesModel()).courses;
  }

  /// 删除指定收藏课程
  static Future<Null> deleteCollections(List<int> deleteList) async {
    await HttpUtil.post('/course/information/collection/delete',
        data: {"list": deleteList});
  }

  /// 获取最近浏览的10节课程
  static Future<List<SimpleCoursesModel>> getBrowseCourse() async {
    final response = await HttpUtil.get('/course/list/latest-browse');
    return CourseManageModel.fromJson(response, SimpleCoursesModel()).courses;
  }

  /// 获取正在进行考试 / 已完成的考试课程
  static Future<CourseManageModel> getExamCourse(int page) async {
    final response = await HttpUtil.get('/examine/user-exam', data: {
      "page": page,
    });
    return CourseManageModel.fromJson(response, ExamCoursesModel());
  }
}
