import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/utils/http_util.dart';

class ProfileDao {
  static Future<ProfileModel> checkLogin() async {
    final response = await HttpUtil.request('/passport/check-login');
    return ProfileModel.fromJson(response);
  }
}
