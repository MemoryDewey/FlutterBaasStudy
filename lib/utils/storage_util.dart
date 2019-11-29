import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static set(String key, dynamic value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value is int)
      await preferences.setInt(key, value);
    else if (value is double)
      await preferences.setDouble(key, value);
    else if (value is bool)
      await preferences.setBool(key, value);
    else if (value is String)
      await preferences.setString(key, value);
    else if (value is List<String>)
      await preferences.setStringList(key, value);
    else if (value is Map)
      await preferences.setString(key, json.encode(value));
    else
      await preferences.setString(key, value.toString());
  }

  static Future<dynamic> get(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key);
  }

  static Future<double> getDouble(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  static Future<List<String>> getStringList(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key);
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String mapStr = preferences.getString(key);
    return mapStr == null ? null : json.decode(mapStr);
  }

  static remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }

  static clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
