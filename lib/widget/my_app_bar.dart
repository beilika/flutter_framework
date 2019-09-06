import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  //appbar透明度
  double appBarAlpha = 0;
  bool isShowDrawer = true;
  String title;//标题

  MyAppBar({Key key,this.appBarAlpha,this.isShowDrawer = true,this.title = '首页'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //导航栏 Opacity包裹，可以改变组件透明度
    return Opacity(
      //必传参数
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        //decoration 装饰器, 背景色为白色
        decoration: BoxDecoration(color: Colors.white,),
        child: Row(
          children: <Widget>[
            //判断是否显示，调出左边抽屉按钮
            Visibility(
              visible: isShowDrawer,
              child: GestureDetector(
                onTap: (){
                  Scaffold.of(context).openDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5,top: 20),
                  child: Icon(Icons.format_align_justify),
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(title),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
