import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeLight() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xfff2f2f2),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.grey[900]),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xffededed),
      ),
      splashColor: Colors.white,
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black87,
        labelColor: Colors.blueAccent,
      ),
    );
  }

  static ThemeData themeDark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xff2b2b2b),
      appBarTheme: AppBarTheme(
        color: Color(0xff3b3b3b),
        brightness: Brightness.dark,
      ),
      cardColor: Color(0xff373737),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xff2b2b2b),
      ),
      splashColor: Color(0xff373737),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.tealAccent[200],
        unselectedLabelColor: Colors.white,
      ),
    );
  }
}
