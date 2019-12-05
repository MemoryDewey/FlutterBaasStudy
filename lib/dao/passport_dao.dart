import 'package:baas_study/model/passport_model.dart';
import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/utils/http_util.dart';

class PassportDao {
  /// 检查用户是否登录
  static Future<ProfileModel> checkLogin() async {
    final response = await HttpUtil.request('/passport/check-login');
    return ProfileModel.fromJson(response);
  }

  /// 使用账号密码登录
  static Future<PswLoginModel> pswLogin({
    String account,
    String psw,
  }) async {
    final response = await HttpUtil.request(
      '/passport/m-login-psw',
      data: {
        "account": account,
        "password": psw,
      },
      method: 'post',
    );
    return PswLoginModel.fromJson(response);
  }
}
