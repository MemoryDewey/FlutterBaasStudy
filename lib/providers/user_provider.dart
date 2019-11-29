import 'package:baas_study/model/profile_model.dart';
import 'package:baas_study/utils/storage_util.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  static const String User_Key = 'userInfo';
  UserModel _user;

  UserModel get user => _user;

  bool get hasUser => _user != null;

  UserProvider() {
    _init();
  }

  void _init() async {
    Map<String, dynamic> userMap = await StorageUtil.getMap(User_Key);
    _user = userMap != null ? UserModel.fromJson(userMap) : null;
  }

  /// 保存用户信息
  saveUser(UserModel user) {
    _user = user;
    notifyListeners();
    StorageUtil.set(User_Key, user.toJson());
  }

  /// 清除用户信息
  clearUser() {
    _user = null;
    notifyListeners();
    StorageUtil.remove(User_Key);
  }
}
