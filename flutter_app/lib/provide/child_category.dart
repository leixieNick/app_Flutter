import 'package:flutter/material.dart';
import '../model/categoryModel.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';

  // 点击大类时更换
  getChildCategory(List<BxMallSubDto> list) {
    categoryId = '4';
    childIndex = 0;

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId='00';
    all.mallCategoryId='00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类的索引值
  changeChildIndex(index){
    childIndex = index;
    notifyListeners();
  }
}