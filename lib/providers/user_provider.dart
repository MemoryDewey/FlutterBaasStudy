import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/utils/storage_util.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  static const String _USER_KEY = 'userInfo';
  static const String _WALLET_KEY = 'userWallet';
  UserModel _user;
  String _walletBalance;

  UserModel get user => _user;

  String get balance => _walletBalance;

  bool get hasUser => _user != null;

  UserProvider() {
    _init();
  }

  void _init() async {
    Map<String, dynamic> userMap = await StorageUtil.getMap(_USER_KEY);
    _user = userMap != null ? UserModel.fromJson(userMap) : null;
    String balance = await StorageUtil.getString(_WALLET_KEY);
    _walletBalance = balance ?? '';
  }

  /// 保存用户信息
  saveUser(UserModel user) {
    _user = user;
    notifyListeners();
    StorageUtil.set(_USER_KEY, user.toJson());
  }

  /// 保存用户钱包余额信息
  saveWalletInfo(String balance) {
    _walletBalance = balance;
    notifyListeners();
    StorageUtil.set(_WALLET_KEY, balance);
  }

  /// 清除用户信息
  clearUser() {
    _user = null;
    notifyListeners();
    StorageUtil.remove(_USER_KEY);
  }

  /// 清除钱包信息
  clearWalletInfo() {
    _walletBalance = null;
    notifyListeners();
    StorageUtil.remove(_walletBalance);
  }
}
