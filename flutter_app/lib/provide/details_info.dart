import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;
  var valueData = null;

  // 注意：async await 的添加，不然数据返回流程不对
  getGoodsInfo(String id) async {
    var formData = {'goodId':id};
    await request('getGoodDetailById',formData: formData).then((value) {
      var data = json.decode(value.toString());
      print('getGoodDetailById = ${data}');
      goodsInfo = DetailsModel.fromJson(data);
      valueData = data;

      notifyListeners();
    });
  }
}