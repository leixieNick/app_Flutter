import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
        appBar: AppBar(title: Text('首页'),),
        body: FutureBuilder(builder: (context, snapshot){
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            // 轮播图
            List<Map> swiperListData = (data['data']['slides'] as List).cast();
            // 导航区
            List<Map> navigatorListData = (data['data']['category'] as List).cast();
            // 广告图片
            String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            // 店铺信息
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];

            return Column(
              children: [
                // 轮播图
                SwiperDiy(swiperListData: swiperListData),
                // 导航区
                TopNavigator(navigatorListData: navigatorListData),
                // 广告图片
                AdBanner(advertesPicture: advertesPicture),
                // 店铺信息
                ShopInfo(leaderImage: leaderImage, leaderPhone: leaderPhone,),
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

// 首页导航区
class TopNavigator extends StatelessWidget {
  final List navigatorListData;
  TopNavigator({Key key, this.navigatorListData}):super(key:key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: (){
        print('点击了导航栏');
      },
      child: Column(
        children: [
          Image.network(item['image'],width: ScreenUtil().setWidth(750 / 7),),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(190),
      color: Color.fromARGB(1, 239, 239, 239),
      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(4.0),
        child: GridView.count(crossAxisCount: 1,
          scrollDirection: Axis.horizontal,
          children: navigatorListData.map((item) {
            return _gridViewItemUI(context, item);
          }).toList(),
        ),
      )
    );
  }
}

// 广告图片
class AdBanner extends StatelessWidget {
  final String advertesPicture;
  AdBanner({Key key, this.advertesPicture}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}

// 店铺信息
class ShopInfo extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  ShopInfo({Key key, this.leaderImage, this.leaderPhone}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

    _launchURL() async {
      String url = 'tel:'+leaderPhone;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
}



