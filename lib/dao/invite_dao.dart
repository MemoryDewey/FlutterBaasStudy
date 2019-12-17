import 'package:baas_study/model/invite_model.dart';
import 'package:baas_study/utils/http_util.dart';

class InviteDao {
  /// 获取邀请人数列表
  static Future<InviteResultModel> getInviteList(int page) async {
    final response = await HttpUtil.get('/profile/personal/invite', data: {
      "page": page,
    });
    return InviteResultModel.fromJson(response);
  }

  /// 获取个人邀请信息
  static Future<InviteCodeModel> getInviteCode() async {
    final response = await HttpUtil.get('/profile/personal/invite-code');
    return InviteCodeModel.fromJson(response);
  }
}
