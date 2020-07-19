import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterbase/util/my_toast.dart';
import 'package:orientation/orientation.dart';

/// @author 强周亮(qiangzhouliang)
/// @desc app 公共的一些操作，如页面初始化等
/// @email 2538096489@qq.com
/// @time 2020/6/24 21:25
class App {
  //app 初始化的一些操作
  static void initApp(BuildContext context){
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
//    ScreenUtil.init(allowFontScaling: true);
    //默认是1920*1080大小
    ScreenUtil.init(context,width: 375,height: 812);

    /// 设置屏幕方向
    setOrientationUp();
    //初始化toast轻提示
    MyToast.init(context);
  }

  /// android 设置状态栏为透明的沉浸
  static submergence_status_bar() {
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  //设置屏幕竖屏
  static setOrientationUp(){
    /// DeviceOrientation.portraitUp, //只能纵向
    /// DeviceOrientation.portraitDown,//只能纵向
//    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
  }
}