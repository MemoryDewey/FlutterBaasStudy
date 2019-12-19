import 'dart:async';
import 'dart:io';
import 'package:baas_study/model/reponse_normal_model.dart';
import 'package:baas_study/utils/token_util.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

/// 封装Http请求
class HttpUtil {
  static Dio dio;

  /// 设置请求地址
  static const String URL_PREFIX = 'http://47.102.97.205';

  /// WebSocket请求地址
  static const String WEBSOCKET_URL_PREFIX = 'ws://47.102.97.205';

  /// API前缀
  static const String _API_PREFIX = '$URL_PREFIX/api';

  /// 连接服务器超时时间
  static const int _CONNECT_TIMEOUT = 10000;

  /// 接收数据的最长时间
  static const int _RECEIVE_TIMEOUT = 5000;

  /// 请求错误信息
  static String _errorMsg(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return '请求服务器超时';
      case DioErrorType.RECEIVE_TIMEOUT:
        return '服务器未响应';
      case DioErrorType.RESPONSE:
        return error.response.statusCode == 404
            ? '请求的资源不存在'
            : ResponseNormalModel.fromJson(error.response.data).msg;
      default:
        return '发生了未知的错误';
    }
  }

  /// get请求
  static Future<dynamic> get(String url, {Map<String, dynamic> data}) async {
    if (data != null && data.isNotEmpty) {
      StringBuffer options = StringBuffer('?');
      data.forEach((key, value) {
        options.write('$key=$value&');
      });
      String optionStr = options.toString();
      optionStr = optionStr.substring(0, optionStr.length - 1);
      url += optionStr;
    }
    return await request(url, method: "GET");
  }

  /// post请求
  static Future<dynamic> post(String url, {Map<String, dynamic> data}) async {
    return await request(url, data: data, method: 'POST');
  }

  /// 封装所有请求
  static Future<dynamic> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';
    Dio dio = await createInstance();
    var result;

    try {
      Response response = await dio.request(
        url,
        data: data,
        options: Options(method: method),
      );
      result = response.data;

      /// 打印响应相关信息
      print('--> $method $url 200');
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      String errorMsg = _errorMsg(e);
      BotToast.showText(text: errorMsg, align: Alignment(0, 0));
    }

    return result;
  }

  /// FormData请求，用于上传文件
  static Future<dynamic> upload(String url, File file) async {
    Dio dio = await createInstance();
    String path = file.path;
    String filename = path.substring(path.lastIndexOf('/') + 1, path.length);
    FormData formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(
        file.path,
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      )
    });
    var result;
    try {
      Response response = await dio.post(url, data: formData);
      result = response.data;

      /// 打印响应相关信息
      print('--> upload $url 200');
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      String errorMsg = _errorMsg(e);
      BotToast.showText(text: errorMsg, align: Alignment(0, 0));
    }

    return result;
  }

  /// 创建 dio 实例对象
  static Future<Dio> createInstance() async {
    if (dio == null) {
      /// 获取Token
      String _token = await TokenUtil.get();

      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions option = BaseOptions(
        baseUrl: _API_PREFIX,
        connectTimeout: _CONNECT_TIMEOUT,
        receiveTimeout: _RECEIVE_TIMEOUT,
        headers: {"authorization": _token},

        /// [responseType] 表示期望以那种格式(方式)接受响应数据。
        /// [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`
        responseType: ResponseType.json,
      );
      dio = Dio(option);
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }

  /// 获取图片URL
  static String getImage(String url) => URL_PREFIX + url;
}
