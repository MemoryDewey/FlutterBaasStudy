import 'dart:async';
import 'package:baas_study/utils/token_util.dart';
import 'package:dio/dio.dart';

/// 封装Http请求
class HttpUtil {
  static Dio dio;

  /// 设置请求地址
  static const String URL_PREFIX = 'http://47.102.97.205';

  /// API前缀
  static const String _API_PREFIX = '$URL_PREFIX/api';

  /// 连接服务器超时时间
  static const int _CONNECT_TIMEOUT = 10000;

  /// 接收数据的最长时间
  static const int _RECEIVE_TIMEOUT = 5000;

  /// token
  static String _token;

  static Future<dynamic> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';
    _token = await TokenUtil.getToken('token');

    /// 请求处理
    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    Dio dio = createInstance();
    var result;

    try {
      Response response = await dio.request(
        url,
        data: data,
        options: new Options(method: method),
      );
      result = response.data;

      /// 打印响应相关信息
      print('响应数据成功！');
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print(e.response);
      print('请求出错：' + e.toString());
    }

    return result;
  }

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions option = new BaseOptions(
        baseUrl: _API_PREFIX,
        connectTimeout: _CONNECT_TIMEOUT,
        receiveTimeout: _RECEIVE_TIMEOUT,
        headers: {"user-agent": "dio", "authorization": _token},

        /// [responseType] 表示期望以那种格式(方式)接受响应数据。
        /// [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`
        responseType: ResponseType.json,
      );
      dio = new Dio(option);
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}
