import 'dart:io';
import 'package:baas_study/providers/dark_mode_provider.dart';
import 'package:baas_study/navigator/tab_navigator.dart';
import 'package:baas_study/providers/provider_manage.dart';
import 'package:baas_study/theme/app_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  /// 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
      providers: providers,
      child: BotToastInit(
        child: Consumer<DarkModeProvider>(
          builder: (context, darkModeModel, child) {
            return darkModeModel.darkMode == DarkModel.auto
                ? autoMode
                : manualMode(darkModeModel.darkMode);
          },
        ),
      )));
  if (Platform.isAndroid) {
    /// 设置android状态栏为透明的沉浸。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Color(0x00),
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Widget get autoMode {
  return MaterialApp(
    title: '区块课堂',
    theme: AppTheme.themeLight(),
    darkTheme: AppTheme.themeDark(),
    navigatorObservers: [BotToastNavigatorObserver()],
    home: TabNavigator(),

    /// 添加中文语言包
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      RefreshLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('zh', 'CH'),
      const Locale('en', 'US'),
    ],
    localeResolutionCallback:
        (Locale locale, Iterable<Locale> supportedLocales) {
      return locale;
    },
  );
}

Widget manualMode(DarkModel darkModel) {
  return MaterialApp(
    title: '区块课堂',
    theme: darkModel == DarkModel.off
        ? AppTheme.themeLight()
        : AppTheme.themeDark(),
    navigatorObservers: [BotToastNavigatorObserver()],
    home: TabNavigator(),

    /// 添加中文语言包
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      RefreshLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('zh', 'CH'),
      const Locale('en', 'US'),
    ],
    localeResolutionCallback:
        (Locale locale, Iterable<Locale> supportedLocales) {
      return locale;
    },
  );
}
