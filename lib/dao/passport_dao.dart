import 'package:baas_study/model/passport_model.dart';
import 'package:baas_study/utils/http_util.dart';

class PassportDao {
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
