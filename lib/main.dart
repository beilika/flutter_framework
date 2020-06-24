import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_framework/navigator/tab_navigator.dart';

import 'navigator/my_bottom_app_bar.dart';
import 'util/scream_util.dart';
/// flutter 应用程序入口
void main(){
  runApp(MyApp());

  //设置android沉侵式状态栏
  submergence_status_bar();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //强制竖屏
    setScreamDirection(DeviceOrientation.portraitUp);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter 开发框架封装',
//      theme: ThemeData(primarySwatch: Colors.lightBlue,),
        //不带底部+号的底部导航栏
//      home: TabNavigator(),
    //带底部＋号的底部导航栏
      home: MyBottomAppBar(),
    );
  }
}


