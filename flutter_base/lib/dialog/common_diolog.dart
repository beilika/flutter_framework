import 'package:flutter/material.dart';
import 'package:flutterbase/common/line_widget.dart';
import 'package:flutterbase/util/global_config.dart';
import 'package:flutterbase/util/screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef void DoneClicked();
/// @author 强周亮(qiangzhouliang)
/// @desc 公共dialog
/// @email 2538096489@qq.com
/// @time 2020/6/23 18:29
class CommonDialog extends Dialog {
  String content;
  bool isShowCancle;
  DoneClicked doneClicked;

  static void show(context,content,{barrierDismissible = false,isShowCancle = true,doneClicked,}) {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return CommonDialog(
            content: content,
            isShowCancle: isShowCancle,
            doneClicked:(){
              Navigator.pop(context);
              doneClicked();
            },
          );
        });
  }

  CommonDialog({
    Key key,
    this.content,
    this.isShowCancle,
    this.doneClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtils.screenW(context) - ScreenUtils.getScaleW(context, 60);
    double rasius = 10.0;

    Widget titleImgWidget = Container(
      width: width,
      height: ScreenUtils.getScaleW(context, 44),
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      decoration: new BoxDecoration(
        color: GlobalConfig.bluefontColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(rasius), topRight: Radius.circular(rasius),)
      ),
      child: Center(
        child: Text('提示',style: TextStyle(color: Colors.white,fontSize: 32.sp),),
      ),
    );

    Widget contentWidget = Container(
      margin: EdgeInsets.only(top: 0),
      width: width,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border.all(width: 0, color: Colors.white),
      ),
      child: Center(
        child: Text(
          content,
          style: (TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(102, 102, 102, 1),
          )),
        ),
      ),
    );

    List<Widget> btnList = <Widget>[
      Expanded(
        child: GestureDetector(
          onTap: () {
            if (doneClicked != null) {
              doneClicked();
            }
          },
          child: Container(
            child: Text(
              '确定',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: GlobalConfig.bluefontColor),
            ),
          ),
        ),
      ),
    ];

    if (isShowCancle) {
      btnList.insert(
          0,
          Container(
            color: Color.fromRGBO(221, 221, 221, 1),
            width: 1.0,
            height: 44,
          ));

      btnList.insert(
          0,
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Text(
                  '取消',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(153, 153, 153, 1)),
                ),
              ),
            ),
          ));
    }

    Widget reviewBtnWidget = Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(rasius),
            bottomRight: Radius.circular(rasius),
          ),
        ),
      ),
      height: 44,
      width: width,
      child: Row(
        children: btnList,
      ),
    );

    return WillPopScope(
      child: new Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: new Center(
            child: Container(
          decoration: new BoxDecoration(
            color: Colors.transparent,
            border: new Border.all(width: 0, color: Colors.transparent),
          ),
          width: width,
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              titleImgWidget,
              contentWidget,
              LineWidget.line_w(),
              reviewBtnWidget,
            ],
          ),
        )),
      ),
      onWillPop: () async {
        return Future.value(false);
      },
    );
  }
}
