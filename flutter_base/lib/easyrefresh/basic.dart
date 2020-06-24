import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'footer.dart';
import 'header.dart';

/// 基本示例(经典样式)页面
class BasicPage extends StatefulWidget {
  /// 标题
  final String title;

  const BasicPage(this.title, {Key key}) : super(key: key);

  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  EasyRefreshController _controller;
  ScrollController _scrollController;
  // 条目总数
  int _count = 20;
  // 方向
  Axis _direction = Axis.vertical;
  // 控制结束
  bool _enableControlFinish = false;
  // 是否开启刷新
  bool _enableRefresh = true;
  // 是否开启加载
  bool _enableLoad = true;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          height: _direction == Axis.vertical ? double.infinity : 210.0,
          child: EasyRefresh.custom(
            controller: _controller,
            scrollController: _scrollController,
            header: _enableRefresh ? header(context):null,
            footer: _enableLoad? footer() : null,
            onRefresh: _enableRefresh
                ? () async {
                    await Future.delayed(Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          _count = 20;
                        });
                        if (!_enableControlFinish) {
                          _controller.resetLoadState();
                          _controller.finishRefresh();
                        }
                      }
                    });
                  }
                : null,
            onLoad: _enableLoad
                ? () async {
                    await Future.delayed(Duration(seconds: 2), () {
                      if (mounted) {
                        setState(() {
                          _count += 20;
                        });
                        if (!_enableControlFinish) {
                          _controller.finishLoad(noMore: _count >= 80);
                        }
                      }
                    });
                  }
                : null,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                    return Text('init $index');
                  },
                  childCount: _count,
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        _enableControlFinish
            ? FlatButton(
                onPressed: () {
                  _controller.resetLoadState();
                  _controller.finishRefresh();
                },
                child: Text('完成刷新',
                    style: TextStyle(color: Colors.black)))
            : SizedBox(
                width: 0.0,
                height: 0.0,
              ),
        _enableControlFinish
            ? FlatButton(
                onPressed: () {
                  _controller.finishLoad(noMore: _count >= 80);
                },
                child: Text('完成加载',
                    style: TextStyle(color: Colors.black)))
            : SizedBox(
                width: 0.0,
                height: 0.0,
              ),
        FlatButton(
            onPressed: () {
              _controller.callRefresh();
            },
            child: Text('刷新',
                style: TextStyle(color: Colors.black))),
        FlatButton(
            onPressed: () {
              _controller.callLoad();
            },
            child: Text('加载更多',
                style: TextStyle(color: Colors.black))),
      ],
    );
  }
}
