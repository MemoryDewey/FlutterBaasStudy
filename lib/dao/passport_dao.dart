import 'package:baas_study/model/passport_model.dart';
import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/utils/http_util.dart';

class PassportDao {
  /// 检查用户是否登录
  static Future<ProfileModel> checkLogin() async {
    final response = await HttpUtil.get('/passport/mobile-check-login');
    return ProfileModel.fromJson(response);
  }

  /// 使用账号密码登录
  static Future<LoginModel> pswLogin({
    String account,
    String psw,
  }) async {
    final response = await HttpUtil.post(
      '/passport/m-login-psw',
      data: {
        "account": account,
        "password": psw,
      },
    );
    HttpUtil.clear();
    return LoginModel.fromJson(response);
  }

  /// 使用验证码登录
  static Future<LoginModel> verifyCodeLogin({
    String phone,
    String code,
  }) async {
    final response = await HttpUtil.post('/passport/m-login', data: {
      "phone": phone,
      "code": code,
    });
    HttpUtil.clear();
    return LoginModel.fromJson(response);
  }

  /// 获取验证码
  static Future<ResponseNormalModel> sendShortMsgCode({
    String option,
    String phone,
  }) async {
    final response =
        await HttpUtil.post('/passport/short-message-captcha', data: {
      "account": phone,
      "option": option,
    });
    return ResponseNormalModel.fromJson(response);
  }

  /// 获取邮箱验证码
  static Future<ResponseNormalModel> sendMailCode({
    String email,
  }) async {
    final response = await HttpUtil.post('/passport/email-captcha', data: {
      "account": email,
    });
    return ResponseNormalModel.fromJson(response);
  }

  /// 添加邮箱
  static Future<EmailModel> bindEmail({String email, String code}) async {
    final response = await HttpUtil.post('/passport/add-email', data: {
      "account": email,
      "verifyCode": code,
    });
    return EmailModel.fromJson(response);
  }

  /// 解除已绑定的邮箱
  static Future<String> unbindEmail() async {
    final response = await HttpUtil.get('/passport/delete-email');
    return ResponseNormalModel.fromJson(response).msg;
  }

  /// 改变手机号
  static Future<String> changeMobile({
    Map<String, dynamic> data,
    int step,
  }) async {
    final res = await HttpUtil.post('/passport/change-mobile', data: {
      "data": data,
      "step": step,
    });
    if (res == null)
      return res;
    else if (res == "OK") return "OK";
    return ResponseNormalModel.fromJson(res).msg;
  }

  /// 修改密码
  static Future<String> changePsw({
    Map<String, dynamic> data,
    int step,
  }) async {
    final res = await HttpUtil.post('/passport/mobile-reset', data: {
      "data": data,
      "step": step,
    });
    if (res == null)
      return res;
    else if (res == "OK") return "OK";
    return ResponseNormalModel.fromJson(res).msg;
  }
}
