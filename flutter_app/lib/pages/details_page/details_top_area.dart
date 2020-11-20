import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/details_info.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    print('goodsInfo = ${goodsInfo}');
    if (goodsInfo != null) {
      return Container(
        color: Colors.orange,
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            _goodsImage(goodsInfo.image1),
            _goodsName( goodsInfo.goodsName ),
            _goodsNum(goodsInfo.goodsSerialNumber),
            _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice),
          ],
        ),
      );
    }else {
      return Text('data');
    }
  }

  Widget _goodsImage(url) {
    return Image.network(url, width: ScreenUtil().setWidth(740),);
  }

  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      child: Text(
        name,
        maxLines: 1,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }

  Widget _goodsNum(num){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Text(
        '编号:${num}',
        style: TextStyle(
            color: Colors.black26
        ),
      ),
    );
  }

  Widget _goodsPrice(presentPrice,oriPrice){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              color:Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12),
            child:Text(
              '市场价:￥${oriPrice}',
              style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough
              ),
            ),
          )
        ],
      ),
    );
  }
}




// class DetailsTopArea extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Provide(builder: (context, child, value){
//       var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
//       print('goodsInfo = ${goodsInfo}');
//       if (goodsInfo != null) {
//         return Container(
//           color: Colors.red,
//           child: Column(
//             children: [
//               _goodsImage(goodsInfo.image1),
//             ],
//           ),
//         );
//       }else {
//         return Text('data');
//       }
//     },);
//   }
//
//   Widget _goodsImage(url) {
//     return Image.network(url, width: ScreenUtil().setWidth(740),);
//   }
// }
