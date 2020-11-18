import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/categoryModel.dart';
import 'package:provide/provide.dart';
import '../model/categoryGoodsList.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('商品分类'),),
        body: Container(
          child: Row(
            children: [
              LeftCategoryNav(),
              Column(
                children: [
                  RightCategoryNav(),
                  CategoryGoodsList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 左侧大类列表页
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryDataModel> list = [];
  var listIndex = 0; //索引

  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());
      CategoryModel model = CategoryModel.fromJson(data);
      setState(() {
        list = model.data;
      });

      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
      print(list[0].bxMallSubDto);
      list[0].bxMallSubDto.forEach((element) {
        print(element.mallSubName);
      });
    });
  }

  void _getGoodList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1
    };
    print('data = ${data}');
    await request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(model.data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12),
        )
      ),
      child: ListView.builder(itemBuilder: (context, index) {
        return _leftInkWel(index);
      },
        itemCount: list.length,),
    );
  }

  Widget _leftInkWel(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList, categoryId);
        _getGoodList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(top: 13),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          )
        ),
        child: Text(list[index].mallCategoryName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(26)),
              textAlign: TextAlign.center,),
      ),
    );
  }
}

// 右侧小类类别
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  void _getGoodList({String categorySubId}) async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };
    print('data1 = ${data}');
    await request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(model.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<ChildCategory>(builder: (context, child, childCategory){
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setWidth(80),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.black12),
              )
          ),
          child: ListView.builder(itemBuilder: (context, index) {
            return _rightInkWell(index, childCategory.childCategoryList[index]);
          },
            itemCount: childCategory.childCategoryList.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      }),
    );
  }
  
  Widget _rightInkWell (int index, BxMallSubDto item) {
    bool isCheck = false;
    isCheck = (index == Provide.value<ChildCategory>(context).childIndex) ? true : false;

    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index);
        _getGoodList(categorySubId: item.mallSubId);
      },
      child: Container(
        padding:EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        child: Text(item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(26),
            color: isCheck ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}

// 右侧商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(builder: (context, child, data){
      return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            color: Colors.red,
            child: ListView.builder(itemBuilder: (context, index) {
              return _ListWidget(data.goodsList, index);
            },
              itemCount: data.goodsList.length,
            ),
          ));
    },
    );
  }

  Widget _ListWidget(List newList, int index){
    return InkWell(
        onTap: (){

        },
        child: Container(
          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0,color: Colors.black12)
              )
          ),

          child: Row(
            children: <Widget>[
              _goodsImage(newList, index),
              Column(
                children: <Widget>[
                  _goodsName(newList, index),
                  _goodsPrice(newList, index)
                ],
              )
            ],
          ),
        )
    );

  }

  Widget _goodsImage(List newList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList, index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List newList, index){
    return  Container(
        margin: EdgeInsets.only(top:10.0),
        padding: EdgeInsets.all(5.0),
        width: ScreenUtil().setWidth(370),
        child:Row(
            children: <Widget>[
              Text(
                '价格:￥${newList[index].presentPrice}',
                style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
              Text(
                '￥${newList[index].oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough
                ),
              )
            ]
        )
    );
  }
}


