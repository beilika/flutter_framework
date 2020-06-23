import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_framework/widget/drawer/smart_drawer.dart';
import 'package:flutterbase/update/app_update_util.dart';

/// @author 强周亮(qiangzhouliang)

/// @desc 左侧抽屉界面

/// @email 2538096489@qq.com

/// @time 2020/6/22 15:58

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  //系统自己的
  Widget userHeader = UserAccountsDrawerHeader(
    accountName: Text('张三'),
    accountEmail: Text('abc@itcast.cn'),
    currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://images.gitee.com/uploads/91/465191_vsdeveloper.png?1530762316'),),
    //美化当前控件
    decoration: BoxDecoration(
      //用户背景
        image: DecorationImage(
            image:NetworkImage('http://www.liulongbin.top:3005/images/bg1.jpg'),
            //背景填充模式
            fit: BoxFit.cover
        )
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SmartDrawer(
      widthPercent: 0.7,
      child: ListView(
        //设置listView的内边距为0
        padding: EdgeInsets.zero,
        children: <Widget>[
          userHeader , // 可在这里替换自定义的header
          _ListTitle(context,'Item 1',Icons.school),
          _ListTitle(context,'Item 2',Icons.home),
          Divider(),
          _ListTitle(context,'检查更新',Icons.update,onTap: (){
            CheckUpdateUtil(context).checkUpdate();
          }),
        ],
      ),
      callback: (isOpen) {
        print('打开状态：$isOpen');
      },
    );
  }
}
Widget _ListTitle(BuildContext context,String title,IconData icon,{GestureTapCallback onTap}){
  return ListTile(title: Text(title),
    leading: CircleAvatar(child: Icon(icon),),
    onTap: onTap,
  );
}