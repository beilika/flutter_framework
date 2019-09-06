import 'package:flutter/material.dart';
import 'package:flutter_framework/navigator/tab_navigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/// flutter 应用程序入口
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //默认 width : 1080px , height:1920px , allowFontScaling:false
//    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}

