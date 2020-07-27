import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterbase/util/log/log_util.dart';
import 'package:flutterbase/util/log/logger.dart';
import 'package:flutterbase/util/my_toast.dart';
import 'package:orientation/orientation.dart';
import 'package:sp_util/sp_util.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';

/// @author 强周亮(qiangzhouliang)
/// @desc app 公共的一些操作，如页面初始化等
/// @email 2538096489@qq.com
/// @time 2020/6/24 21:25
class App {
  //app 初始化的一些操作
  static initApp(BuildContext context){
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
//    ScreenUtil.init(allowFontScaling: true);
    //默认是1920*1080大小
    ScreenUtil.init(context,width: 375,height: 812);

    //初始化toast轻提示
    MyToast.init(context);
  }

  static initMain(){
    _initFileDownlod();
    _initUmeng();
    _submergence_status_bar();
    /// 设置屏幕方向
    _setOrientationUp();
    _initLog();
    _initSpUtil();
  }

  /// android 设置状态栏为透明的沉浸
  static _submergence_status_bar() {
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
  static _setOrientationUp(){
    /// DeviceOrientation.portraitUp, //只能纵向
    /// DeviceOrientation.portraitDown,//只能纵向
//    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
  }

  //初始化友盟统计的一些工作
  static _initUmeng(){
    UmengAnalyticsPlugin.init(
      iosKey: "5f1a38eeb4fa6023ce194f84",
      androidKey: "5f1a3894b4fa6023ce194f68",
      channel: "flutter_framework",
      logEnabled: false
    );
  }

  //打印日志初始化
  static _initLog(){
    /// 添加console日志打印
    bool isDebug = !bool.fromEnvironment("dart.vm.product");
    LogUtil.addLogger(PrintLogger(isDebug),isShowLog: true);

    /// 添加debug文件日志
//    LogUtil.addLogger(DebugLogger('dir', 'logName'));
    /// 添加error文件日志
//    LogUtil.addLogger(ErrorLogger('dir', 'logName'));
  }

  //下载文件初始化
  static _initFileDownlod() async {
    //下载文件,初始化只能进行一次,写在其他页面调用第二次会报错
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
      debug: false,
    );
  }

  static _initSpUtil() async {
    await SpUtil.getInstance();
  }
}