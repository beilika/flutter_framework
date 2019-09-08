import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_framework/router/customer_route.dart';

class NavigatorUtil {
  ///跳转到指定页面
  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
  ///跳转到指定页面，带右划返回上一页
  static pushRightBack(BuildContext context, Widget page) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
  }
  ///跳转到指定页面
  static pushCustomRouter(BuildContext context, Widget page) {
    Navigator.push(context, CustomerRoute(page));
  }
  ///返回上一页面
  static pop(BuildContext context){
    Navigator.pop(context);
  }
}
