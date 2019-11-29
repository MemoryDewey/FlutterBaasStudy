import 'package:baas_study/utils/storage_util.dart';
import 'package:flutter/foundation.dart';

enum DarkModel { off, on, auto }

/// 控制夜间模式模型
class DarkModeProvider with ChangeNotifier {
  DarkModel _darkModel;
  static const Map<int, DarkModel> DARK_MODE_MAP = {
    0: DarkModel.off,
    1: DarkModel.on,
    2: DarkModel.auto,
  };
  static const String STORE_KEY = 'darkMode';

  DarkModel get darkMode => _darkModel;

  DarkModeProvider() {
    _init();
  }

  void _init() async {
    int localMode = await StorageUtil.getInt(STORE_KEY);

    /// 默认夜间模式跟随系统
    changeMode(DARK_MODE_MAP[localMode] ?? DARK_MODE_MAP[2]);
  }

  void changeMode(DarkModel darkModel) async {
    _darkModel = darkModel;
    notifyListeners();
    StorageUtil.set(STORE_KEY, darkModel.index);
  }
}
