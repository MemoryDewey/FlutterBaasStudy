import 'package:baas_study/model/exam_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/utils/http_util.dart';

class ExamDao {
  /// 获取考试试卷
  static Future<ExamInfoModel> getExamResult(int courseID) async {
    final response = await HttpUtil.post('/examine/exam', data: {
      "courseID": courseID,
    });
    return ExamInfoModel.fromJson(response);
  }

  /// 答题
  static Future<ResponseNormalModel> submitAnswer(SubmitExamModel model) async {
    final response = await HttpUtil.post('/examine/add', data: model.toJson());
    return ResponseNormalModel.fromJson(response);
  }
}
