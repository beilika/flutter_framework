import 'package:flutter/material.dart';
import 'package:flutterbase/app/app.dart';
import 'navigator/my_bottom_app_bar.dart';
import 'package:flutterbase/common/my_app_common.dart';
/// flutter 应用程序入口
void main(){
  runApp(MyApp());

  //设置android沉侵式状态栏
  App.submergence_status_bar();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //不带底部+号的底部导航栏
//    return MyAppCommon.getApp(TabNavigator());
    //带底部＋号的底部导航栏
    return MyAppCommon.getApp(widget:MyBottomAppBar());
  }
}


