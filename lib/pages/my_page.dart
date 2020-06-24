import 'package:flutter/material.dart';
import 'package:flutter_framework/widget/warp_demo.dart';
import 'package:flutterbase/base_exp.dart';

/*我的界面*/
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    //Scaffold 实现了基本的 Material Design 布局结构
    return Scaffold(
      appBar: myAppBar(context, '我的',isShowLead: false),
      body: Center(
        child: WarpDemo(),
      ),
    );
  }
}