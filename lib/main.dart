import 'package:flutter/material.dart';
import 'package:flutter_framework/navigator/tab_navigator.dart';

import 'navigator/my_bottom_app_bar.dart';
/// flutter 应用程序入口
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
//      home: TabNavigator(),
      home: MyBottomAppBar(),
    );
  }
}


