import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/base_exp.dart';
import 'package:flutterlogin/login.dart';
import 'package:framework_flutter/pages/travel_page.dart';
import 'package:framework_flutter/widget/drawer/my_drawer.dart';
import 'package:framework_flutter/widget/my_app_bar.dart';
import 'package:framework_flutter/widget/my_swiper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutterbase/common/my_app_common.dart';
import 'package:umeng_analytics_plugin/umeng_analytics_plugin.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';

import 'file_picker_demo.dart';
import 'image_picker_demo.dart';
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
    UmengAnalyticsPlugin.pageStart("HomePage");
    list..add(MySwiper(imageUrls: _imageUrls))..add(ListTile(
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
    ))..add(ListTile(
      title: Text('文件选择'),
      onTap: (){
        NavigatorUtil.pushRightBack(context, FilePickerDemo());
      },
    ))..add(ListTile(
      title: Text('拍照和视频录制'),
      onTap: (){
        NavigatorUtil.pushRightBack(context, ImagePickerDemo());
      },
    ))..add(ListTile(
      title: Text('查看大图'),
      onTap: (){
        NavigatorUtil.pushRightBack(context, PhotoViewGalleryScreen(
          images: [
            'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2700645530,2666290277&fm=26&gp=0.jpg',
            'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3802653641,1514041303&fm=26&gp=0.jpg',
          ],
          index: 0,
          heroTag: '美女',
        ));
      },
    ))..add(ListTile(
      title: Text('文件下载'),
      onTap: (){
        FileDownload().doDownloadOperation(context, filePathAll: 'https://einvoicelink.51fapiao.cn:8181/FPFX/actions/52ffc5c947a321f8907478303188544709b299', fileName: "learning_android_studio.pdf");
      },
    ))..add(ListTile(
      title: Text('时间选择'),
      onTap: (){
        DatePicker.showDatePicker(
            context, showTitleActions: true,
            minTime:DateTime.now(),
            onConfirm: (date) {
              MyToast.toast(msg: formatDate(date, [yyyy, "-", mm, "-", dd]));
            }, locale: LocaleType.zh);
      },
    ));
    hideScreen();
  }

  @override
  Widget build(BuildContext context) {
    App.initApp(context);
    return MyAppCommon.getApp(widget:Scaffold(
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
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context,index){
                      return list[index];
                    }
                ),
              )
          ),
          MyAppBar(appBarAlpha: appBarAlpha,),
        ],
      ),
      //左边抽屉
      drawer: MyDrawer(),
    ));
  }
  ///延迟隐藏闪屏页
  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 600), () {
//      FlutterSplashScreen.hide();
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

  @override
  void dispose() {
    super.dispose();
    UmengAnalyticsPlugin.pageEnd("HomePage");
  }
}