import 'package:baas_study/model/comment_model.dart';
import 'package:baas_study/utils/http_util.dart';

class CommentDao {
  /// 添加评论
  static Future<CommentAddModel> addComment({
    int id,
    double star,
    String comment,
  }) async {
    final response = await HttpUtil.post('/course/comment', data: {
      "id": id,
      "star": star.floor(),
      "comment": comment,
    });
    return CommentAddModel.fromJson(response);
  }

  /// 获取评论数
  static Future<CommentCountModel> getCount(int id) async {
    final response =
        await HttpUtil.get('/course/comment/count', data: {
      "id": id,
    });
    return CommentCountModel.fromJson(response);
  }

  /// 获取评论
  static Future<CommentListModel> getCommentList({
    int id,
    int page = 1,
    int filter = 0,
  }) async {
    final response = await HttpUtil.get('/course/comment', data: {
      "id": id,
      "page": page,
      "filter": filter,
    });
    return CommentListModel.fromJson(response);
  }
}
