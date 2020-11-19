import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/service/service_method.dart';
import 'package:provide/provide.dart';

import '../provide/details_info.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  void _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成............');
  }

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);

    return Container(
      child: Text('商品id = ${goodsId}'),
    );
  }
}
