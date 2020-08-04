import 'package:flutter/material.dart';

/*
 *系统主题设置，包括系统默认字体 背景色等
 */
class GlobalConfig {

  //是否加密参数 true 加密，false 不加密
  static bool isEncryPara = true;
  //配置不加密的URL
  static var passUrl = [];

  static Color bluefontColor = Color.fromRGBO(38,154,243, 1.0);

  //自定义标题色
  static MaterialColor themeColor = const MaterialColor(
    0xFF269af3,
    const <int, Color>{
      50: const Color.fromRGBO(38,154,243, 1.0),
      100: const Color.fromRGBO(38,154,243, 1.0),
      200: const Color.fromRGBO(38,154,243, 1.0),
      300: const Color.fromRGBO(38,154,243, 1.0),
      400: const Color.fromRGBO(38,154,243, 1.0),
      500: const Color.fromRGBO(38,154,243, 1.0),
    },
  );

  //路由
  static final String routingLogin = '/router/login_Page';

  //导航栏返回按钮颜色
  static Color backBtnColor = Color.fromRGBO(151, 151, 151, 1.0);

  static TextStyle navTextStyle = TextStyle(fontSize: 18.0, color: Color.fromRGBO(51, 51, 51, 1),fontWeight: FontWeight.w400);
  //线条的默认颜色
  static Color line_color() => Color(0xffDDDDDD);

}

