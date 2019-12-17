import 'package:baas_study/model/wallet_model.dart';
import 'package:baas_study/utils/http_util.dart';

class WalletDao {
  /// 获取余额信息
  static Future<WalletModel> getWalletInfo() async {
    final response = await HttpUtil.get('/wallet');
    return WalletModel.fromJson(response);
  }

  /// 获取余额交易记录
  static Future<WalletLogsModel> getBalanceLogs(int page) async {
    final response = await HttpUtil.get('/wallet/logs', data: {"page": page});
    return WalletLogsModel.fromJson(response);
  }
}
