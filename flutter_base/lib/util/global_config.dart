import 'package:flutter/material.dart';

/*
 *系统主题设置，包括系统默认字体 背景色等
 */
class GlobalConfig {

  static Color bluefontColor = Color.fromRGBO(38,154,243, 1.0);

  //路由
  static final String routingLogin = '/router/login_Page';

  //导航栏返回按钮颜色
  static Color backBtnColor = Color.fromRGBO(151, 151, 151, 1.0);

  static TextStyle navTextStyle = TextStyle(fontSize: 18.0, color: Color.fromRGBO(51, 51, 51, 1),fontWeight: FontWeight.w400);

}

