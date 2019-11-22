import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DarkModel { on, off, manual }

/// 控制夜间模式模型
class DarkModeModel with ChangeNotifier {
  int _darkMode;
  static const Map<int, String> DARK_MODE_MAP = {
    0: '关闭',
    1: '开启',
    2: '跟随系统',
  };
  static const String STORE_KEY = 'darkMode';

  ///使用SharedPreferences来保存用户配置
  SharedPreferences _preferences;

  int get darkMode => _darkMode;

  DarkModeModel() {
    _init();
  }

  void _init() async {
    this._preferences = await SharedPreferences.getInstance();
    int localMode = this._preferences.get(STORE_KEY);

    /// 默认夜间模式跟随系统
    changeMode(localMode ?? 2);
  }

  void changeMode(int darkMode) async {
    _darkMode = darkMode;
    notifyListeners();
    SharedPreferences preferences =
        this._preferences ?? SharedPreferences.getInstance();
    await preferences.setInt(STORE_KEY, darkMode);
  }
}
