import 'package:baas_study/model/comment_model.dart';
import 'package:baas_study/utils/http_util.dart';

class CommentDao {
  /// 添加评论
  static Future<CommentAddModel> addComment({
    int courseID,
    double star,
    String comment,
  }) async {
    final response = await HttpUtil.post('/course/information/comment', data: {
      "courseID": courseID,
      "star": star.floor(),
      "comment": comment,
    });
    return CommentAddModel.fromJson(response);
  }

  /// 获取评论数
  static Future<CommentCountModel> getCount(int courseID) async {
    final response =
        await HttpUtil.get('/course/information/comment/count', data: {
      "courseID": courseID,
    });
    return CommentCountModel.fromJson(response);
  }

  /// 获取评论
  static Future<CommentListModel> getCommentList({
    int courseID,
    int page = 1,
    int filter = 0,
  }) async {
    final response = await HttpUtil.get('/course/information/comment', data: {
      "courseID": courseID,
      "page": page,
      "filter": filter,
    });
    return CommentListModel.fromJson(response);
  }
}
