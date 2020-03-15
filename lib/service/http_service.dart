import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';

Future get(url,{query}) async{
  try{
    Response response;
    Dio dio = new Dio();
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    response = await dio.get(url,queryParameters: query??{});
    Map<String,dynamic> res = json.decode(response.toString());
    if(response.statusCode == 200 && res['code'] == "0"){
      return res['data'];
    }else{
      throw Exception("请求接口错误请检查网络和服务器");
    }
  }catch(e){
    if(e.toString().contains("timed out")){
      print("接口请求超时:::url:$url");
    }else{
      print(e);
    }
  }
}

Future post(url,{data}) async{
  try{
    // 实例化Dio对象
    Dio dio = new Dio();
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    // 获取请求结果
    Response response = await dio.post(url,data: data??{});
    // 转化为json对象
    Map<String,dynamic> res = json.decode(response.toString());
    // 判断结果

    if(response.statusCode == 200 && res['code'] == "0"){
      return res['data'];
    }else{
      throw Exception("请求接口错误请检查网络和服务器");
    }
  }catch(e){
    if(e.toString().contains("timed out")){
      print("接口请求超时:::url:$url");
    }else{
      print(e);
    }
  }
}