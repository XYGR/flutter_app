import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class HttpUtils {
  static const BASE_URL = "http://10.10.1.2:3000";
  static const CONNECT_TIMEOUT = 5000;
  static const RECEIVE_TIMEOUT = 3000;
  static Dio dio;

  /// 生成Dio实例
  static Dio getInstance() {
    if (dio == null) {
//      Map<String, dynamic> headers = new Map();
//      headers['Cookie'] = cookie;
      //通过传递一个 `BaseOptions`来创建dio实例
      var options = BaseOptions(
          baseUrl: BASE_URL,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT);
      dio = new Dio(options);
    }
    return dio;
  }

  /// 请求api
  static Future<Map> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? "get";

    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    // 打印请求相关信息：请求地址、请求方式、请求参数
    print("请求地址：【$method $url】");
    print("请求参数：【$data】");

    var dio = getInstance();
    var res;
    if (method == "get") {
      // get
      print(data);
      var response = await dio.get(url,queryParameters: new Map<String, dynamic>.from(data));
      res = response.data;
    } else {
      // post
      var response = await dio.post(url, data: data);

      res = response.data;
    }

    return jsonDecode(res);
  }

  /// get
  static Future<Map> get(url, [data])async{
    data = data??{};
    // 初始化SharedPreferences对象
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 从本地持久化中获取session数据
    String sessionID = prefs.getString('sessionID')??'';
    data["sessionID"] = sessionID;
    return request(url, data: data);
  }

  /// post
  static Future<Map> post(url, [data])async{
    data = data??{};
    // 初始化SharedPreferences对象
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 从本地持久化中获取session数据
    String sessionID = prefs.getString('sessionID')??' ';
    data["sessionID"] = sessionID;
    return request(url, data: data, method: "post");
  }

}