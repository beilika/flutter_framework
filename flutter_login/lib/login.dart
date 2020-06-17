import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*登录*/
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  //重写keepAlive 为ture ，就是可以有记忆功能了。
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    //Scaffold 实现了基本的 Material Design 布局结构
    return Scaffold(
        body:Container(
          color: Colors.grey[200],
          child: GestureDetector(
            child: Center(
              child: Text('登录',style: TextStyle(fontSize: 36.0),),
            ),
            onTap: () {
              Fluttertoast.showToast(
                msg: "确定要登录吗？",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
              );
            },
          ),
        )
    );
  }
}