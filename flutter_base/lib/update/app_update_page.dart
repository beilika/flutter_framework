import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterbase/common/global_config.dart';
import 'package:flutterbase/util/my_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_update/ota_update.dart';

import 'model/app_update_entity.dart';

String apkName = '测试.apk';

class AppUpdatePage extends StatefulWidget {
  final AppUpdateEntity appUpdateEntity;

  String androidUrl;

  AppUpdatePage({Key key, this.appUpdateEntity, this.androidUrl,}) : super(key: key);

  @override
  _AppUpdatePageState createState() => _AppUpdatePageState();
}

class _AppUpdatePageState extends State<AppUpdatePage> {
  String _text = '下载中';

  int _progress = null;

  @override
  void initState() {
    super.initState();
    downloadAndroidApp(widget.androidUrl);
  }
  downloadAndroidApp(String url) {
    try {
      OtaUpdate().execute(url, destinationFilename: '测试.apk').listen(
        (OtaEvent event) {
          print('status:${event.status},value:${event.value}');
          switch (event.status) {
            case OtaStatus.DOWNLOADING: // 下载中
              setState(() {
                _text = '下载中:${event.value}%';
              });
              break;
            case OtaStatus.INSTALLING: //安装中
              _text = '安装中';
              break;
            case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
              MyToast.toast(msg: "更新失败，请稍后再试 ");
              setState(() {
                _text = '下载失败';
                _progress = 0;
              });
              break;
            default: // 其他问题
              break;
          }
        },
      );
    } catch (e) {
      MyToast.toast(msg: "更新失败，请稍后再试 ");
      setState(() {
        _text = '下载失败';
        _progress = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.screenWidth - 40.w;

    Widget iconWidget = Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
      padding: EdgeInsets.all(0),
      child: Image.asset('images/Android.png', fit: BoxFit.fill, width: 70, height: 70,),
    );

    Widget version = Text(
      '版本号：v${widget.appUpdateEntity?.version == null ? '': widget.appUpdateEntity.version}',
      style: (TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(102, 102, 102, 1),
      )),
    );

    Widget LinearProgress = Container(
      margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
      //限制进度条的高度
      height: 6.0,
      //限制进度条的宽度
      width: width,
      child: new LinearProgressIndicator(
          //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
          value: _progress==null?null:_progress/100.0,
          //背景颜色
          backgroundColor: Color.fromRGBO(221, 221, 221, 1),
          //进度颜色
          valueColor:
              new AlwaysStoppedAnimation<Color>(GlobalConfig.bluefontColor)),
    );

    Widget textWidget = Text(
      _text,
      style: (TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(102, 102, 102, 1),
      )),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('版本升级', style: GlobalConfig.navTextStyle,),
          centerTitle: true,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0.5,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              iconWidget,
              version,
              LinearProgress,
              textWidget,
            ],
          ),
          margin: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
