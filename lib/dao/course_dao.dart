import 'package:baas_study/model/certificate_model.dart';
import 'package:baas_study/model/course_info_model.dart';
import 'package:baas_study/model/course_manage_model.dart';
import 'package:baas_study/model/course_model.dart';
import 'package:baas_study/model/course_video_model.dart';
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
    final response = await HttpUtil.get(
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
      '/course/list/user-course-coin',
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
    final response = await HttpUtil.get('/course/info/cancel-free',
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
    await HttpUtil.post('/course/info/collection/delete',
        data: {"list": deleteList});
  }

  /// 获取最近浏览的10节课程
  static Future<List<SimpleCoursesModel>> getBrowseCourse() async {
    final response = await HttpUtil.get('/course/list/latest-browse');
    List<SimpleCoursesModel> model = [];
    if (response != null)
      response.forEach((v) {
        model.add(new SimpleCoursesModel.fromJson(v));
      });
    return model;
  }

  /// 获取正在进行考试 / 已完成的考试课程
  static Future<CourseManageModel> getExamCourse(int page) async {
    final response = await HttpUtil.get('/examine/user-exam', data: {
      "page": page,
    });
    return CourseManageModel.fromJson(response, ExamCoursesModel());
  }

  /// 检查用户是否报名
  static Future<bool> checkCourseApply(int id) async {
    final response = await HttpUtil.get('/course/info/class', data: {
      "id": id,
    });
    return response['code'] == 1000;
  }

  /// 获取课程详情
  static Future<CourseInfoDetailModel> getInfoDetail(int id) async {
    final response = await HttpUtil.get('/course/info', data: {
      "id": id,
    });
    return CourseInfoDetailModel.fromJson(response);
  }

  /// 获取第一节课视频
  static Future<VideoFirstModel> getFirstVideo(int id) async {
    final response = await HttpUtil.get('/course/video/first', data: {
      "id": id,
    });
    return VideoFirstModel.fromJson(response);
  }

  /// 获取直播课程信息
  static Future<LiveModel> getLiveInfo(int id) async {
    final response = await HttpUtil.get('/course/video/live', data: {
      "id": id,
    });
    return LiveModel.fromJson(response);
  }

  /// 获取录播课程信息
  static Future<ChapterInfoModel> getChapterInfo(int id) async {
    final response = await HttpUtil.get('/course/video/chapter', data: {
      "id": id,
    });
    return ChapterInfoModel.fromJson(response);
  }

  /// 收藏/取消收藏课程
  static Future<ResponseNormalModel> courseCollect(int id, int value) async {
    final response = await HttpUtil.get('/course/info/collect-course', data: {
      "id": id,
      "value": value,
    });
    return ResponseNormalModel.fromJson(response);
  }

  /// 报名免费课程
  static Future<CourseApplyModel> applyFree(int id) async {
    final response = await HttpUtil.post('/course/apply/free', data: {
      "id": id,
    });
    return response == null ? null : CourseApplyModel.fromJson(response);
  }

  /// 报名付费课程
  static Future<CourseApplyModel> buyCourse(int id) async {
    final response = await HttpUtil.post('/course/apply/buy-course', data: {
      "id": id,
    });
    return response == null ? null : CourseApplyModel.fromJson(response);
  }

  /// 获取证书信息
  static Future<CertificateModel> getCertificate(int page) async {
    final response = await HttpUtil.get('/course/list/certificate', data: {
      "page": page,
    });
    return CertificateModel.fromJson(response);
  }
}
