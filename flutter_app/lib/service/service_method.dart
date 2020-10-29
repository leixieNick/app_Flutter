import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

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