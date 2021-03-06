import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/routers/Routes.dart';
import 'package:fluro/fluro.dart';
import './routers/Routes.dart';
import './routers/application.dart';

import './pages/index_page.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';

void main() {

  Counter counter;
  var providers  =Providers();

  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide));

  //runApp(MyApp());
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('2020-11-25 技术胖百姓生活+ 照着博客基本完成');
    print('2020-11-25 技术胖百姓生活+ 未完成部分：1. 首页刷新 2. 购物车显示数字和跳转 3. 分类进入时数据加载');

    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: 'flutter-shop',
        debugShowCheckedModeBanner: false,

        onGenerateRoute: Application.router.generator,

        theme: ThemeData(
          primaryColor: Colors.pinkAccent
        ),
        home: IndexPage(),
      ),
    );
  }
}