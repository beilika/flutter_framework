import 'package:flutter/cupertino.dart';
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

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //Scaffold 实现了基本的 Material Design 布局结构
    return Scaffold(
        body:Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //输入用户名
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone,),
                    labelText: '请输入电话号码',
                  ),
                  autofocus: false,
                ),
                //输入密码
                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: '请输入密码',
                  ),
                  autofocus: false,
                ),
                //登录
                button_widget('登录',_login),
              ],
            ),
          )
        )
    );
  }

  //公共按钮组件
  Padding button_widget(String title,VoidCallback onPressed,{Color color = Colors.blue,double minWidth = 200.0}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      child: ButtonTheme(
        minWidth: minWidth,
        height: 40.0,
        child:  RaisedButton(
          color: color,
          textColor: Colors.white,
          onPressed: onPressed,
          child: Text(title),
        ),
      )
    );
  }

  //登录方法
  void _login(){
    print({'user': phoneController.text,'pass':passController.text});
    if(phoneController.text.length != 11) {
      Fluttertoast.showToast(
          msg: "请输入正确的手机号码",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else if(passController.text.length == 0){
      Fluttertoast.showToast(
          msg: "密码不能为空",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Fluttertoast.showToast(
          msg: "登录成功",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0
      );
      onTextClear();
    }
  }

  //清空内容
  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
    });
  }
}