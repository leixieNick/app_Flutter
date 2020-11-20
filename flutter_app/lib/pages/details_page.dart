import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/detals_web.dart';

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
          print('snapshot = ${snapshot.data}');
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: [
                  DetailsTopArea(),
                  DetailsExplain(),
                  DetailsTabBar(),
                  DetailsWeb(),
                ],
              ),
            );
          }else {
            return Text('数据加载中111...');
          }
        },
          future: _getBackInfo(context),

          // future: getGoodsInfo(goodsId),
        ),
      ),
    );
  }


  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成............');

    // return 值的返回，不然 snapshot.data 会一直为空
    var valueData = Provide.value<DetailsInfoProvide>(context).valueData;
    return valueData;
  }
}
