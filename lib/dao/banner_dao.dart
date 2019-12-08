import 'package:baas_study/utils/http_util.dart';
import 'package:baas_study/model/banner_model.dart';

class BannerDao {
  static Future<BannerModel> fetch() async {
    final response = await HttpUtil.request('/course/list/banner');
    return BannerModel.fromJson(response);
  }
}
