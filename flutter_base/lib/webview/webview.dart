import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutterbase/base_exp.dart';
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];
/// @author 强周亮(qiangzhouliang)
/// @desc 自定义浏览器组件
/// @email 2538096489@qq.com
/// @time 2020/6/25 18:58
class WebView extends StatefulWidget {
  final String url;
  final String title;
  final bool hideAppBar;
  final bool backForbid; //是否禁止返回
  WebView({Key key, this.url, this.title, this.hideAppBar = true, this.backForbid = false}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  //创建实例
  final webviewReference = FlutterWebviewPlugin();
  //存储监听事件
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChange;
  StreamSubscription<WebViewHttpError> _onHttpError;
  //判断是否已经返回
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((url){

    });
    _onStateChange = webviewReference.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.startLoad: //开始加载
          if (_isToMain(state.url) && !exiting) {
            //是否禁止返回
            if (widget.backForbid) {
              //打开当前页
              webviewReference.launch(widget.url);
            } else {
              //返回到上一页
              Navigator.pop(context);
              exiting = true;
            }
          }
         break;
        default:
          break;
      }
    });
    //加载错误监听
    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error){
      print(error);
    });
  }
  //判断是否包含在白名单里面
  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }
  @override
  void dispose() {
    //取消注册监听
    _onUrlChanged.cancel();
    _onStateChange.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
        widget.hideAppBar ? myAppBar(context, widget.title,isShowLead: widget.backForbid):Container(),
          //Expanded 撑满屏幕
          Expanded(
            // WebviewScaffold webview 插件封装的插件插件
              child: WebviewScaffold(
                userAgent: 'null',//防止携程H5页面重定向到打开携程APP ctrip://wireless/xxx的网址
                url: widget.url,
                withZoom: true,  //是否缩放
                withLocalStorage: true, //缓存
                hidden: true,  //默认是否隐藏
                //设置加载时的样式
                initialChild: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('Waiting...'),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}