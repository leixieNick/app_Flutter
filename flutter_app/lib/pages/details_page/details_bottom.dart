import 'package:flutter/material.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:flutter_app/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;
    var count = 1;

    return Container(
      color: Colors.lightBlueAccent,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: [
          _IconCart(),
          _addToCart(context, goodsId, goodsName, count, price, images),
          _buyShop(context),
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

  Widget _addToCart(context, goodsId, goodsName, count, price, images) {
    return Container(
      child: InkWell(
        onTap: (){
          print('加入购物车');
          Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
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

  Widget _buyShop(context) {
    return Container(
      child: InkWell(
        onTap: (){
          print('立即购买');
          Provide.value<CartProvide>(context).remove();
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
