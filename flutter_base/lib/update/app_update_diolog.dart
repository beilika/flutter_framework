import 'package:flutter/material.dart';
import 'package:flutterbase/base_exp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef void APPUpdateDialogUpdateCallBack();

class APPUpdateDialog extends Dialog {
  String content;
  bool needForcedUpdating;
  APPUpdateDialogUpdateCallBack doneClicked;

  APPUpdateDialog({
    Key key,
    this.content,
    this.needForcedUpdating,
    this.doneClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.screenWidth - 112.w;

    Widget titleImgWidget = Container(
      width: width,
      height: width * 123.0 / 263.0,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      decoration: new BoxDecoration(
        color: Colors.transparent,
        border: new Border.all(width: 0.0, color: Colors.transparent),
      ),
      child: Image.asset('images/app_update_titleImg.png', fit: BoxFit.fill,),
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
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(102, 102, 102, 1),
          )),
        ),
      ),
    );

    Widget lineWidget = Container(
      margin: EdgeInsets.all(0),
      width: width,
      height: 0.8,
      color: Color.fromRGBO(221, 221, 221, 1),
    );

    List<Widget> btnList = <Widget>[
      Expanded(
        child: GestureDetector(
          onTap: () {
//                Navigator.pop(context);
            if (doneClicked != null) {
              doneClicked();
            }
          },
          child: Container(
            child: Text(
              '立即更新',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 16.0, color: GlobalConfig.bluefontColor),
            ),
          ),
        ),
      ),
    ];

    if (!needForcedUpdating) {
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
                  style: TextStyle(
                      fontSize: 16.0, color: Color.fromRGBO(153, 153, 153, 1)),
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
            bottomLeft: Radius.circular(14.0),
            bottomRight: Radius.circular(14.0),
          ),
        ),
      ),
      height: 44,
      width: ScreenUtil.screenWidth - 60.w,
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
              lineWidget,
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
