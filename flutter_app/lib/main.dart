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

void main() {

  Counter counter;
  var providers  =Providers();

  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));

  //runApp(MyApp());
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

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