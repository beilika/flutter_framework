import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_framework/pages/travel_page.dart';
import 'package:flutter_framework/widget/my_app_bar.dart';
import 'package:flutter_framework/widget/drawer/my_drawer.dart';
import 'package:flutter_framework/widget/my_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutterbase/base_exp.dart';
import 'package:flutterlogin/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:orientation/orientation.dart';

import 'movie_page.dart';
//滚动的最大值,阈值
const APPBAR_SCROLL_OFFSET = 100;
//appbar透明度
double appBarAlpha = 0;
/*首页界面*/
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://pic33.nipic.com/20131007/13639685_123501617185_2.jpg',
    'http://pic1.win4000.com/wallpaper/c/53cdd1f7c1f21.jpg',
    'http://pic16.nipic.com/20111006/6239936_092702973000_2.jpg'
  ];
  //样例列表
  List list = List();

  @override
  void initState() {
    super.initState();
    list..add(ListTile(
          title: Text('点击跳转登录'),
          onTap: (){
            NavigatorUtil.pushRightBack(context, Login());
          },
        ))..add(ListTile(
      title: Text('动态权限获取'),
      onTap: (){
        CommonDialog.show(context,"在使用XXX11功能前，您先需要授予一下权限，否则，将无法使用该功能！",doneClicked: (){
          PermissionUtil(success: (){
            print('success');
          }).requestPermission([Permission.storage,Permission.camera]);

        });
      },
    ))..add(ListTile(
      title: Text('下拉刷新，上拉加载更多'),
      onTap: (){
        NavigatorUtil.pushRightBack(context, BasicPage('刷新加载'));
      },
    ))..add(ListTile(
      title: Text('顶部标题栏滑动效果'),
      onTap: (){
        NavigatorUtil.pushRightBack(context, TravelPage());
      },
    ))..add(ListTile(
      title: Text('webView的使用'),
      onTap: (){
        NavigatorUtil.pushRightBack(context, WebView(url: 'https://www.baidu.com',title: '百度一下',backForbid: true,));
      },
    ))..add(ListTile(
      title: Text('视频播放插件使用'),
      onTap: (){
        NavigatorUtil.pushRightBack(context, MoviePage());
      },
    ));
    hideScreen();
  }

  @override
  Widget build(BuildContext context) {

    App.initApp(context);
    //Scaffold 实现了基本的 Material Design 布局结构
    return Scaffold(
      //Stack 层叠组件，前面的元素在上面，后面的元素在下面
        body: Stack(
          children: <Widget>[
            // MediaQuery 具有删除padding的属性
            MediaQuery.removePadding(
              //移除顶部padding
                removeTop: true,
                context: context,
                //NotificationListener 可以监听列表的滚动
                child:NotificationListener(
                  //监听列表的滚动
                  // ignore: missing_return
                  onNotification: (scrollNotification){
                    //scrollNotification.depth 第0 个元素，也就是listview的第一个元素开始滚动的时候
                    if(scrollNotification is ScrollNotification && scrollNotification.depth == 0){
                      //滚动且是列表滚动的时候
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: ListView(
                    children: <Widget>[
                      MySwiper(imageUrls: _imageUrls),
                      Container(
                        height: ScreenUtil.screenHeight,
                        //ListTile 通常用于在 Flutter 中填充 ListView
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context,index){
                            return list[index];
                          }),
                      )
                    ],
                  ),
                )
            ),
            MyAppBar(appBarAlpha: appBarAlpha,),
          ],
        ),
      //左边抽屉
      drawer: MyDrawer(),
    );
  }
  ///延迟隐藏闪屏页
  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 600), () {
      FlutterSplashScreen.hide();
    });
  }
  //滚动处理操作
  _onScroll(offset){
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if(alpha < 0){
      //向上滚动
      alpha = 0;
    }else if(alpha > 1){
      //向下滚动
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
}