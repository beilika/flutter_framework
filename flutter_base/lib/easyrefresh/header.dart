import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutterbase/util/global_config.dart';

ClassicalHeader header(BuildContext context,{headerFloat = false}) {
  return ClassicalHeader(
    enableInfiniteRefresh: false,
    bgColor: Colors.grey[200],
    infoColor: GlobalConfig.bluefontColor,
    //是否浮动
    float: headerFloat,
    //是否开启震动
    enableHapticFeedback: false,
    refreshText: '拉动刷新',
    refreshReadyText: '释放刷新',
    refreshingText: '刷新',
    refreshedText: '刷新完成',
    refreshFailedText: '刷新失败',
    noMoreText: '没有更多数据',
    infoText: '更新于 %T',
  );
}