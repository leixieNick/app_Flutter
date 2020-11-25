import 'package:flutter/material.dart';

class FindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('发现'),),
        body: ListView(
          children: [
            _cellItem(),
          ],
        ),
      ),
    );
  }

  Widget _cellItem() {
    return Container(
      child: Column(
        children: [
          _findListTile('第一项'),
        ],
      ),
    );
  }

  Widget _findListTile(String tileTitle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        )
      ),
      child: ListTile(
        title: Text(tileTitle),
      ),
    );
  }
}
