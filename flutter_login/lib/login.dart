import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterbase/base_exp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_state_tool.dart';
import 'login_textField.dart';
/*登录*/
class Login extends StatefulWidget {
  //是否是退出登录
  bool isExitLogin;

  Login({this.isExitLogin});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  //重写keepAlive 为ture ，就是可以有记忆功能了。
  @override
  bool get wantKeepAlive => true;

  //账号
  var _accountStr = '';
  //密码
  var _passwordStr = '';
  //自动登录
  var _autoLoginBtnSelected = false;
  //记住密码
  var _rememberPasswordBtnSelected = false;

  //隐藏密码
  var _hiddenPassword = true;
  var counter = 0;

  BuildContext _context;

  @override
  void initState() {
    super.initState();
    //初始化状态数据
    getStateData();
  }
  @override
  Widget build(BuildContext context) {
    _context = context;

    //检查更新
    CheckUpdateUtil(context).getAppVersion();

    Widget title1Widget = Container(
      child: Text(
        '你好,欢迎来到',
        style: TextStyle(
            color: Colors.black, fontSize: 26.sp, fontWeight: FontWeight.w200),
      ),
      width: ScreenUtil.screenWidth - 70.w,
      height: 46.w,
      margin: EdgeInsets.only(top: 30.w,),
    );

    Widget title2Widget = Container(
      child: Text(
        '强大的\nflutter开发框架',
        style: TextStyle(color: Colors.black, fontSize: 28.sp, fontWeight: FontWeight.w400),
        maxLines: 2,
      ),
      width: ScreenUtil.screenWidth - 70.w,
      margin: EdgeInsets.only(
        top: 20,
      ),
    );

    //账号输入框
    Widget accountWidget = Container(
      child: LoginTextField(
        iconStr: 'images/accountIcon.png',
        inputText: _accountStr,
        hintText: '请输入您的账号',
//        keyboardType: TextInputType.number,
        fieldCallBack: (content) {
          _accountStr = content;
        },
      ),
      width: ScreenUtil.screenWidth - 70.w,
      margin: EdgeInsets.only(
        top: 60,
      ),
    );

    //密码输入框
    Widget passwordWidget = Container(
      child: LoginTextField(
        iconStr: 'images/passwordIcon.png',
        inputText: _passwordStr,
        hintText: '请输入您的密码',
        hasdeleteIcon: true,
        hasShowPasswordIcon: true,
        hiddenPassword: _hiddenPassword,
        fieldCallBack: (content) {
          _passwordStr = content;
        },
        showPassWord: (hiddenPassword) {
          _hiddenPassword = hiddenPassword;
          setState(() {
          });
        },
      ),
      width: ScreenUtil.screenWidth - 70.w,
      margin: EdgeInsets.only(
        top: 10,
      ),
    );

    Widget loginBtnWidget = Container(
      width: ScreenUtil.screenWidth - 70.w,
      height: 44.h,
      margin: EdgeInsets.only(
        top: 30,
      ),
      child: RaisedButton(
        child: Text('登录',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400)),
        color: GlobalConfig.bluefontColor,
        textColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        onPressed: () {
          if (_accountStr.length == 0) {
            MyToast.toast(msg: "请输入账号 ", position: ToastPostion.center);
            return;
          }

          if (_passwordStr.length == 0) {
            MyToast.toast(msg: "请输入密码 ", position: ToastPostion.center);
            return;
          }

          startLogin();
        },
      ),
    );

    //自动登录和记住密码
    Widget stateBtnWidget = Container(
      width: ScreenUtil.screenWidth - 70.w,
      height: 20.h,
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: LoginStateTool(
          autoLoginBtnSelected: _autoLoginBtnSelected,
          rememberPasswordBtnSelected: _rememberPasswordBtnSelected,
          btnClicked: (autoLoginBtnSelected, rememberPasswordBtnSelected) {
            _autoLoginBtnSelected = autoLoginBtnSelected;
            _rememberPasswordBtnSelected = rememberPasswordBtnSelected;
          }),
    );

    return MaterialApp(
        home: Scaffold(
          //取消键盘弹起时,背景图片会跟随上移变形的情况,
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 触摸收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  title1Widget,
                  title2Widget,
                  accountWidget,
                  passwordWidget,
                  loginBtnWidget,
                  stateBtnWidget,
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/loginBack.png',),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.all(40.h),
              width: ScreenUtil.screenWidth,
              height: ScreenUtil.screenHeight,
            ),
          ),
        ),);
  }

  getStateData() async {
    final prefs = await SharedPreferences.getInstance();
    bool autoLogin = prefs.getBool('AutoLogin');
    bool rememberPassword = prefs.getBool('RememberPassword');

    String accountStr = prefs.getString('AccountStr');
    String passwordStr = prefs.getString('PasswordStr');

    setState(() {
      _autoLoginBtnSelected = autoLogin == null ? false : autoLogin;
      _rememberPasswordBtnSelected =
      rememberPassword == null ? false : rememberPassword;

      _accountStr = accountStr == null ? '' : accountStr;
      _passwordStr = passwordStr == null ? '' : passwordStr;

      if (_autoLoginBtnSelected == true && widget.isExitLogin == false) {
        startLogin();
      }
    });
  }

  startLogin() {
    //开启加载动画
    showLoadingDialog(_context,content: '正在登录...');
    //加密账号密码.
//    encryptData();

    //大后端测试环境
//    getTestBackEndUserInfo();
  }
}