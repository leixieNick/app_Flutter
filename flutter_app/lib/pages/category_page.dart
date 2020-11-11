import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/categoryModel.dart';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';

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
                  RightCategoryNav()
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

      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
      print(list[0].bxMallSubDto);
      list[0].bxMallSubDto.forEach((element) {
        print(element.mallSubName);
      });
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
        Provide.value<ChildCategory>(context).getChildCategory(childList);
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
            return _rightInkWell(childCategory.childCategoryList[index]);
          },
            itemCount: childCategory.childCategoryList.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      }),
    );
  }
  
  Widget _rightInkWell (BxMallSubDto item) {
    return InkWell(
      onTap: (){print(item);},
      child: Container(
        padding:EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
        child: Text(item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
        ),
      ),
    );
  }
}

