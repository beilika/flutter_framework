import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// android 设置状态栏为透明的沉浸
void submergence_status_bar() {
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

/// 设置屏幕方向
/// DeviceOrientation.portraitUp, //只能纵向
/// DeviceOrientation.portraitDown,//只能纵向
void setScreamDirection(DeviceOrientation portrait) {
  SystemChrome.setPreferredOrientations([portrait]);
}