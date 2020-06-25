import 'package:flutter/material.dart';
import 'package:flutterbase/util/global_config.dart';

import 'my_footer.dart';
ClassicalFooter footer() {
  return ClassicalFooter(
    enableInfiniteLoad: false,
    enableHapticFeedback: true,
    bgColor: Colors.grey[200],
    infoColor: GlobalConfig.bluefontColor,
    loadText: '拉动加载',
    loadReadyText: '释放加载',
    loadingText: '正在加载...',
    loadedText: '加载完成',
    loadFailedText: '加载失败',
    noMoreText: '没有更多数据',
    infoText: '更新于 %T',
  );
}