import 'package:baas_study/model/profile_model.dart';
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

    /*_user =userMap!=null?UserModel.fromJson(json)*/
  }
}
