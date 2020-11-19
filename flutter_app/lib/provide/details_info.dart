import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  getGoodsInfo(String id) {
    var formData = {'goodId':id};
    request('getGoodDetailById',formData: formData).then((value) {
      var data = json.decode(value.toString());
      print('data = ${data}');
      goodsInfo = DetailsModel.fromJson(data);

      notifyListeners();
    });
  }
}