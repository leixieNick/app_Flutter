import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import '../provide/currentIndex.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页1'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: '分类'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),label: '购物车'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),label: '会员中心'),
  ];

  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    // TODO: implement initState
    currentPage = tabBodies[currentIndex];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1),
        bottomNavigationBar: BottomNavigationBar(items: bottomTabs,
        type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentPage = tabBodies[currentIndex];
            });
          },
        ),
        body: currentPage,
      ),
    );
  }
}
