import 'package:flutter/material.dart';
import 'package:flutterbase/util/global_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @author 强周亮(qiangzhouliang)
/// @desc 基础样式操作封装
/// @email 2538096489@qq.com
/// @time 2020/6/30 11:43
class BaseWidgetUtil{
  //横线
  static Widget lineBase({height = 0.5}) => Container( height: height, color: GlobalConfig.line_color(),);

  /// @desc 按钮样式
  /// @author 强周亮
  /// @time 2020/7/1 9:47
  /// type 按钮类型 1 取消 0 确定
  static Widget button(BuildContext context,{
    title="取消",
    color = Colors.white,
    @required textColor,type=1,
    @required VoidCallback onPress,
    topLeft = 0.0,topRight = 0.0,bottomLeft = 0.0, bottomRight = 0.0,
    textSize = 14.0}) {
    return Expanded(child: Container(
      child: RaisedButton(
        onPressed: onPress,
        child: Text(title,style: TextStyle(fontSize: ScreenUtil().setSp(textSize)),),
        color: color,
        textColor: textColor,
        elevation:0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(topLeft),topRight: Radius.circular(topRight),bottomLeft: Radius.circular(bottomLeft),bottomRight: Radius.circular(bottomRight))),
      ),
    ),
    );
  }
}