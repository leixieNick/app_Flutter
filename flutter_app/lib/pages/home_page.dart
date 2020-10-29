import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import '../service/service_method.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据...';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('HomePage'),),
        body: FutureBuilder(builder: (context, snapshot){
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperListData = (data['data']['slides'] as List).cast();

            return Column(
              children: [
                // 轮播图
                SwiperDiy(swiperListData: swiperListData),
              ],
            );
          }else {
            return Center(
              child: Text("homePageContent 接口数据获取失败"),
            );
          }
        },
          future: getHomePageContent(),
        )
      ),
    );
  }
}

// 首页轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperListData;
  SwiperDiy({Key key, this.swiperListData}):super(key:key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: new Swiper(itemCount: swiperListData.length,
        itemBuilder: (BuildContext context, int index){
          return Image.network("${swiperListData[index]["image"]}",fit: BoxFit.fill);
        },
        pagination: new SwiperPagination(),
        autoplay: true,
      )
    );
  }
}
