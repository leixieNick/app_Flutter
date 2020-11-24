import 'package:flutter/material.dart';
import 'package:flutter_app/pages/cart_page/cart_bottom.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:provide/provide.dart';

import 'cart_page/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('购物车'),),
        body: FutureBuilder(builder: (context, snapshot) {
          List cartList = Provide.value<CartProvide>(context).cartList;
          print('cartList = ${cartList}');
          print('snapshot = ${snapshot.data}');
          if(snapshot.hasData){
            return Stack(
              children: [
              // ListView.builder(
              //   itemCount: cartList.length,
              //   itemBuilder: (context,index){
              //     return CartItem(cartList[index]);
              //   }),
                Provide<CartProvide>(builder: (context, child, childCategory) {
                  cartList = Provide.value<CartProvide>(context).cartList;
                  return ListView.builder(itemBuilder: (context, index) {
                    return CartItem(cartList[index]);
                  },
                  itemCount: cartList.length,
                  );
                }),
                Positioned(child: CartBottom(),bottom: 0, left: 0,),
              ],
            );
          }else{
            return Text('正在加载');
          }
        },
        future: _getCartInfo(context),
        ),
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
