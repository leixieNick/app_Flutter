import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: [
          _IconCart(),
          _addToCart(),
          _buyShop(),
        ],
      ),
    );
  }

  Widget _IconCart() {
    return Container(
      child: InkWell(
        onTap: (){},
        child: Container(
          color: Colors.white,
          width: ScreenUtil().setWidth(110),
          alignment: Alignment.center,
          child: Icon(Icons.shopping_cart,color: Colors.red,size: 30,),
        ),
      ),
    );
  }

  Widget _addToCart() {
    return Container(
      child: InkWell(
        onTap: (){
          print('加入购物车');
        },
        child: Container(
          color: Colors.green,
          width: ScreenUtil().setWidth(320),
          alignment: Alignment.center,
          child: Text('加入购物车',
            style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),
          ),
        ),
      ),
    );
  }

  Widget _buyShop() {
    return Container(
      child: InkWell(
        onTap: (){
          print('立即购买');
        },
        child: Container(
          color: Colors.red,
          width: ScreenUtil().setWidth(320),
          alignment: Alignment.center,
          child: Text('立即购买',
            style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),
          ),
        ),
      ),
    );
  }

}
