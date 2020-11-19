import 'package:flutter/material.dart';
import 'package:flutter_app/service/service_method.dart';
import 'package:provide/provide.dart';

import '../provide/details_info.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('商品详情页'),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pop(context);
          }),
        ),
        body: FutureBuilder(builder: (context, snapshot){
          if (snapshot.hasData) {
            return Container(
              child: Row(
                children: [

                ],
              ),
            );
          }else {
            return Text('数据加载中...');
          }
        },
          future: _getBackInfo(context),
        ),
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成............');
  }
}
