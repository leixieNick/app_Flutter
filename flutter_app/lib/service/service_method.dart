import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 首页 商品信息
Future getHomePageContent() async {
  try {
    print('开始获取首页数据..........');
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded") as String;
    var formData = {
      'lon':'116.3018569946289',
      'lat':'40.04458999633789'
    };
    response = await dio.post(servicePath['homePageContext'],data: formData);
    if (response.statusCode == 200) {
      print('首页数据获取成功');
      return response.data;
    }else {
      throw Exception('首页数据获取失败，后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(error) {
    return print('ERROR:========>${error}');
  }
}

// 首页 火爆信息
Future getHomePageBelowConten() async {
  try {
    print('开始下拉获取首页的火爆信息数据..........');
    Response response;
    Dio dio = new Dio();
    var formData = {
      'page':'1',
    };
    response = await dio.post(servicePath['homePageBelowConten'],data: formData);
    if (response.statusCode == 200) {
      print('首页商品火爆数据获取成功');
      return response.data;
    }else {
      throw Exception('首页火爆数据获取失败，后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(error) {
    return print('ERROR:========>${error}');
  }
}

// 通用接口封装
Future request(url, {formData}) async {
  try {
    print('开始获取数据..........');
    Response response;
    Dio dio = new Dio();

    // 如果此类型不加，则 'page' = 1 这种格式不会被识别
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();

    if (formData == null) {
      response = await dio.post(servicePath[url]);
    }else {
      print('servicePath = ${servicePath[url]}');
      response = await dio.post(servicePath[url],data: formData);
    }

    if (response.statusCode == 200) {
      print('数据获取成功');
      return response.data;
    }else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(error) {
    return print('ERROR:========>${error}');
  }
}