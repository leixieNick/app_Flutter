import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "";

  List<CartInfoMode> cartList = [];
  double allPrice = 0 ;   //总价格
  int allGoodsCount = 0;  //商品总数量
  bool isAllCheck = true; //是否全选

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList= (temp as List).cast();

    var isHave = false;
    int ival = 0;
    tempList.forEach((element) {
      if (element['goodsId'] == goodsId) {
        tempList[ival]['count'] = element['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      ival ++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images,
        'isCheck': true  //是否已经选择
      };

      tempList.add(newGoods);
      cartList.add(new CartInfoMode.fromJson(newGoods));
      allPrice+= (count * price);
      allGoodsCount+=count;
    }

    cartString = json.encode(tempList).toString();
    print('cartString = ${cartString}');
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  //得到购物车中的商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString=prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartList=[];
    //判断得到的字符串是否有值，如果不判断会报错
    if(cartString==null){
      cartList=[];
    }else{
      List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item){
        cartList.add(new CartInfoMode.fromJson(item));
      });

    }
    notifyListeners();
  }

  //删除购物车中的商品
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    cartList = [];
    allPrice = 0 ;
    allGoodsCount = 0;
    print('清空完成-----------------');
    notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);//
    await getCartInfo();
  }

}