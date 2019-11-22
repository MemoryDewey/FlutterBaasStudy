import 'dart:io';
import 'package:baas_study/model/dark_mode_model.dart';
import 'package:baas_study/navigator/tab_navigator.dart';
import 'package:baas_study/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(builder: (_) => DarkModeModel())],
    child: Consumer<DarkModeModel>(
      builder: (context, darkModeModel, _) {
        return darkModeModel.darkMode == 2
            ? autoMode
            : manualMode(darkModeModel.darkMode);
      },
    ),
  ));
  if (Platform.isAndroid) {
    /// 以下两行 设置android状态栏为透明的沉浸。
    /// 写在组件渲染之后，是为了在渲染后进行set赋值
    /// 覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Color(0x00),
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Widget get autoMode {
  return MaterialApp(
    title: 'Auto Mode',
    theme: AppTheme.themeLight(),
    darkTheme: AppTheme.themeDark(),
    home: TabNavigator(),
  );
}

Widget manualMode(int darkMode) {
  return MaterialApp(
    title: 'Manual Mode',
    theme: darkMode == 0 ? AppTheme.themeLight() : AppTheme.themeDark(),
    home: TabNavigator(),
  );
}
