import 'package:shared_preferences/shared_preferences.dart';

class TokenUtil {
  static const TOKEN_KEY = 'token';

  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(TOKEN_KEY, token);
  }

  static getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(TOKEN_KEY);
  }

  static remToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(TOKEN_KEY);
  }
}
