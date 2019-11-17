import 'package:shared_preferences/shared_preferences.dart';

class TokenUtil {
  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  static getToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }
}
