import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/utils/http_util.dart';

class ProfileDao {
  /// 更改个人信息
  static Future<ResponseNormalModel> changeProfile(
      Map<String, dynamic> data) async {
    final response = await HttpUtil.request('/profile/personal/update',
        data: data, method: 'post');
    return ResponseNormalModel.fromJson(response);
  }

  /// 设置默认头像
  static Future<AvatarModel> setDefaultAvatar() async {
    final response = await HttpUtil.request('/profile/personal/default-avatar');
    return AvatarModel.fromJson(response);
  }
}
