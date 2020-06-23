import 'package:flutter/material.dart';

class LineWidget{
  static const Color _color = Color.fromRGBO(221, 221, 221, 1);
  //展示宽度线
  static Divider line_w({color = _color}) => Divider(height: 0.8,color: color);
}