import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DarkModel { off, on, auto }

/// 控制夜间模式模型
class DarkMode with ChangeNotifier {
  DarkModel _darkModel;
  static const Map<int, DarkModel> DARK_MODE_MAP = {
    0: DarkModel.off,
    1: DarkModel.on,
    2: DarkModel.auto,
  };
  static const String STORE_KEY = 'darkMode';

  ///使用SharedPreferences来保存用户配置
  SharedPreferences _preferences;

  DarkModel get darkMode => _darkModel;

  DarkMode() {
    _init();
  }

  void _init() async {
    this._preferences = await SharedPreferences.getInstance();
    int localMode = this._preferences.get(STORE_KEY);

    /// 默认夜间模式跟随系统
    changeMode(DARK_MODE_MAP[localMode] ?? DARK_MODE_MAP[2]);
  }

  void changeMode(DarkModel darkModel) async {
    _darkModel = darkModel;
    notifyListeners();
    SharedPreferences preferences =
        this._preferences ?? await SharedPreferences.getInstance();
   preferences.setInt(STORE_KEY, darkModel.index);
  }
}
