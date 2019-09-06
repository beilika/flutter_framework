import 'package:flutter/material.dart';

/**
 * 首页界面
 */
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}
/**
 * _:可以定义为私有类，不被外界访问
 */
class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
      accountName: new Text('Tom'),
      accountEmail: new Text('tom@xxx.com'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                  icon: Icon(Icons.wifi_tethering),
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  }
              );
            }
        ),
      ),
      body: new Center(child: new Text('Home page'),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            userHeader , // 可在这里替换自定义的header
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
      ),);
  }
}