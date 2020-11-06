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

class _HomePageState extends State<HomePage>{
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
            // 拼团秒杀
            String saomaoPic = data['data']['saoma']['PICTURE_ADDRESS'];
            String integralMallPic = data['data']['integralMallPic']['PICTURE_ADDRESS'];
            String newUserPic = data['data']['newUser']['PICTURE_ADDRESS'];
            // 商品推荐
            List<Map> recommendListData = (data['data']['recommend'] as List).cast();
            // 楼层
            String floor1Pic = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Pic = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Pic = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1ListData = (data['data']['floor1'] as List).cast();
            List<Map> floor2ListData = (data['data']['floor2'] as List).cast();
            List<Map> floor3ListData = (data['data']['floor3'] as List).cast();

            return SingleChildScrollView(
              child: Container(
                color: Color.fromARGB(1, 238, 238, 238),
                child: Column(
                  children: [
                    // 轮播图
                    SwiperDiy(swiperListData: swiperListData),
                    // 导航区
                    TopNavigator(navigatorListData: navigatorListData),
                    // 广告图片
                    AdBanner(advertesPicture: advertesPicture),
                    // 店铺信息
                    ShopInfo(leaderImage: leaderImage, leaderPhone: leaderPhone,),
                    // 拼团秒杀
                    Tosaoma(saomaPIC: saomaoPic, integralMallPicPIC: integralMallPic, newUserPIC: newUserPic,),
                    // 商品推荐
                    ToRecommend(recommendListData: recommendListData,),
                    // 楼层
                    ToFloorTitle(floorPicAddress: floor1Pic,),
                    ToFloorContent(floorListData: floor1ListData,),
                    ToFloorTitle(floorPicAddress: floor2Pic,),
                    ToFloorContent(floorListData: floor2ListData,),
                    ToFloorTitle(floorPicAddress: floor3Pic,),
                    ToFloorContent(floorListData: floor3ListData,),

                    // 火爆专区
                    HotGoods(),
                  ],
                ),
              )
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

// 拼团秒杀
class Tosaoma extends StatelessWidget {
  final String saomaPIC;
  final String integralMallPicPIC;
  final String newUserPIC;
  Tosaoma({Key key, this.saomaPIC, this.integralMallPicPIC, this.newUserPIC}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.network(saomaPIC, width: ScreenUtil().setWidth(250),fit: BoxFit.fill,),
          Image.network(integralMallPicPIC, width: ScreenUtil().setWidth(250),fit: BoxFit.fill,),
          Image.network(newUserPIC, width: ScreenUtil().setWidth(250),fit: BoxFit.fill,),
        ],
      ),
    );
  }
}

// 商品推荐
class ToRecommend extends StatelessWidget {
  final List recommendListData;
  ToRecommend({Key key, this.recommendListData}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(390),
      color: Colors.greenAccent,
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: [
          _titleWidget(),
          _recommendListView(),
        ],
      ),
    );
  }

  // 商品推荐标题
  Widget _titleWidget() {
    return Container(
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        )
      ),
      child: Text('商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  // 商品推荐列表
  Widget _recommendListView() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(itemBuilder: (context, index) {
        return _recommendItem(index);
      },
        scrollDirection: Axis.horizontal,
        itemCount: recommendListData.length,
      ),
    );
  }

  Widget _recommendItem(index) {
    return Container(
      child: InkWell(
        onTap: (){},
        child: Container(
          height: ScreenUtil().setHeight(330),
          width: ScreenUtil().setWidth(250),
          padding: EdgeInsets.all(8.0),
          decoration:BoxDecoration(
              color:Colors.white,
              border:Border(
                  left: BorderSide(width:1,color:Colors.black12)
              )
          ),
          child: Column(
            children: [
              Image.network(recommendListData[index]['image']),
              Text('${recommendListData[index]['mallPrice']}'),
              Text('${recommendListData[index]['price']}',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 楼层
class ToFloorTitle extends StatelessWidget {
  final String floorPicAddress;
  ToFloorTitle({Key key, this.floorPicAddress}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.network(floorPicAddress),
    );
  }
}

class ToFloorContent extends StatelessWidget {
  final List floorListData;
  ToFloorContent({Key key, this.floorListData}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _firstFloor(),
          _lastFloor(),
        ],
      ),
    );
  }

  Widget _firstFloor() {
    return Container(
      child: Row(
        children: [
          _floorItem(floorListData[0]),
          Column(
            children: [
              _floorItem(floorListData[1]),
              _floorItem(floorListData[2]),
            ],
          )
        ],
      ),
    );
  }

  Widget _lastFloor() {
    return Container(
      child: Row(
        children: [
          _floorItem(floorListData[3]),
          _floorItem(floorListData[4]),
        ],
      ),
    );
  }

  Widget _floorItem(Map item) {
    return Container(
      width:ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){},
        child: Image.network(item['image']),
      ),
    );
  }
}

// 火爆信息
class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {

  int page = 1;
  List<Map> hotGoodsList = [];

  void _getHotGoodData() {
    var formPage = {'page', page};
    request('homePageBelowConten', formData: formPage).then((value) {
      print('value1111 = ${value}');
      var data = json.decode(value.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page ++;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getHotGoodData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
      color: Colors.red,
    );
  }
}







