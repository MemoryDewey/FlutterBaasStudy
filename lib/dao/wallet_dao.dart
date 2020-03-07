import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/model/wallet_model.dart';
import 'package:baas_study/utils/http_util.dart';

class WalletDao {
  /// 获取余额信息
  static Future<WalletModel> getWalletInfo() async {
    final response = await HttpUtil.get('/wallet');
    return response != null ? WalletModel.fromJson(response) : null;
  }

  /// 获取余额交易记录
  static Future<WalletLogsModel> getBalanceLogs(int page) async {
    final response = await HttpUtil.get('/wallet/logs', data: {"page": page});
    return WalletLogsModel.fromJson(response, BalanceLogsModel());
  }

  /// 获取BST交易记录
  static Future<WalletLogsModel> getBstLogs(int page) async {
    final response = await HttpUtil.get('/wallet/bst-logs', data: {
      "page": page,
    });
    return WalletLogsModel.fromJson(response, BstLogsModel());
  }

  /// 获取BST余额
  static Future<BstBalanceModel> getBstBalance(bool refresh) async {
    Map<String, dynamic> data = {};
    if (refresh) data['refresh'] = "true";
    final response = await HttpUtil.get('/wallet/bst-balance', data: data);
    return BstBalanceModel.fromJson(response);
  }

  /// 刷新钱包
  static Future<Null> refreshWallet() async {
    await HttpUtil.get('/wallet/refresh-recharge');
  }

  /// 解除BST钱包绑定
  static Future<Null> unbindWallet() async {
    await HttpUtil.post('/profile/user-address/delete');
  }

  /// 获取加密公钥
  static Future<WalletPubKeyModel> getPubKey() async {
    final response = await HttpUtil.get('/wallet/key');
    return WalletPubKeyModel.fromJson(response);
  }

  /// 添加BST账号
  static Future<ResponseNormalModel> addBstAddress({String address}) async {
    final response =
        await HttpUtil.post('/profile/user-address', data: {
      "address": address,
    });
    return response != null ? ResponseNormalModel.fromJson(response) : null;
  }

  /// 获取BST价格
  static Future<double> getBstValue() async {
    final response = await HttpUtil.get('/course/info/bst-price');
    BstPriceModel model = BstPriceModel.fromJson(response);
    return model.price;
  }

  /// 向服务器发送充值请求
  static Future<Null> sendRechargeReq({int amount}) async {
    await HttpUtil.post('/wallet/recharge', data: {"amount": amount});
  }
}
