import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_framework/util/navigator_util.dart';
import 'package:flutter_framework/widget/my_app_bar.dart';
import 'package:flutter_framework/widget/drawer/my_drawer.dart';
import 'package:flutter_framework/widget/my_swiper.dart';
import 'package:flutter_framework/widget/warp_demo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutterlogin/login.dart';
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
    list..add(
        ListTile(
          title: Text('点击跳转登录'),
          onTap: (){
            NavigatorUtil.pushRightBack(context, Login());
          },
        )
    );
    hideScreen();
  }

  @override
  Widget build(BuildContext context) {
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
//    ScreenUtil.init(allowFontScaling: true);
  //默认是1920*1080大小
    ScreenUtil.init(width: 750,height: 1334);
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