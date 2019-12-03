import 'package:flutter/material.dart';

class PassportTheme {
  final Brightness _brightness;
  bool _isLight;

  PassportTheme(this._brightness) {
    this._isLight = _brightness == Brightness.light;
  }

  Color get topColor => _isLight ? Colors.blue : Color(0xff232323);

  Color get backgroundColor => _isLight ? Color(0xfff2f2f2) : Color(0xff2f2f2f);
}
