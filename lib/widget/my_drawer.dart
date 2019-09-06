import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*首页界面*/
class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  //系统自己的
  Widget userHeader = UserAccountsDrawerHeader(
    accountName: new Text('Tom1'),
    accountEmail: new Text('tom@xxx.com'),
    currentAccountPicture: new CircleAvatar(
      backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),
  );

  @override
  Widget build(BuildContext context) {
    //Scaffold 实现了基本的 Material Design 布局结构
    return Scaffold(
      //Stack 层叠组件，前面的元素在上面，后面的元素在下面
      body:  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            header , // 可在这里替换自定义的header
            ListTile(title: Text('Item 1'),
              leading: new CircleAvatar(child: new Icon(Icons.school),),
              onTap: () {
                Navigator.pop(context);
              },),
            ListTile(title: Text('Item 2'),
              leading: new CircleAvatar(child: new Text('B2'),),
              onTap: () {
                Navigator.pop(context);
              },),
            ListTile(title: Text('Item 3'),
              leading: new CircleAvatar(
                child: new Icon(Icons.list),),
              onTap: () {
                Navigator.pop(context);
              },),
          ],
        ),
      ),
    );
  }

  //自定义
  Widget header = DrawerHeader(
    padding: EdgeInsets.zero, /* padding置为0 */
    child: Stack(children: <Widget>[
      /* 用stack来放背景图片 */
      new Image.network('https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1567760783&di=cd303b67155c424814c713b4a92a78d7&src=http://t-1.tuzhan.com/b589d4c29af9/c-1/l/2012/09/21/08/f8781ba091674f8992bc67b060e0ad91.jpg', fit: BoxFit.fill, width: double.maxFinite,),
      new Align(/* 先放置对齐 */
        alignment: FractionalOffset.bottomLeft,
        child: Container(
          height: 70.0,
          margin: EdgeInsets.only(left: 12.0, bottom: 12.0),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            /* 宽度只用包住子组件即可 */
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new CircleAvatar(
                backgroundImage: NetworkImage('http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg'), radius: 35.0,
              ),
              new Container(
                margin: EdgeInsets.only(left: 6.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 水平方向左对齐
                  mainAxisAlignment: MainAxisAlignment.center, // 竖直方向居中
                  children: <Widget>[
                    new Text("Tom", style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),),
                    new Text("What's up", style: new TextStyle(
                        fontSize: 14.0, color: Colors.white),),
                  ],
                ),
              ),
            ],),
        ),
      ),
    ]),
  );
}