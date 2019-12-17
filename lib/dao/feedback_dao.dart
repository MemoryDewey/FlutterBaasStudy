import 'package:baas_study/model/feedback_mode;.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/utils/http_util.dart';

class FeedbackDao {
  static Future<List<FeedbackTypeModel>> getFeedbackType() async {
    final response = await HttpUtil.get('/profile/personal/feedback-type');
    return FeedbackModel.fromJson(response).feedbackType;
  }

  static Future<ResponseNormalModel> sendFeedback({
    String content,
    int type,
  }) async {
    final response = await HttpUtil.post('/profile/personal/feedback', data: {
      "content": content,
      "type": type,
    });
    return ResponseNormalModel.fromJson(response);
  }
}
