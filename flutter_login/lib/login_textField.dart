import 'package:flutter/material.dart';
import 'package:flutterbase/util/screen_utils.dart';

typedef void LoginTextFieldCallBack(String content);

typedef void LoginTextFieldShowPassWord(bool hiddenPassword);

class LoginTextField extends StatefulWidget {
  final String hintText;
  String inputText;
  String iconStr;
//  TextInputType keyboardType;
  bool hasdeleteIcon;
  bool hasShowPasswordIcon;
  bool hiddenPassword;

  final LoginTextFieldCallBack fieldCallBack;
  final LoginTextFieldShowPassWord showPassWord;

  LoginTextField({
    Key key,
    this.hintText,
    this.inputText: '',
//    this.keyboardType:TextInputType.text,
    this.hasdeleteIcon = false,
    this.hasShowPasswordIcon = false,
    this.iconStr,
    this.hiddenPassword = false,
    this.fieldCallBack,
    this.showPassWord,
  }) : super(key: key);

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {

  @override
  Widget build(BuildContext context) {

    TextEditingController controller;
      controller = TextEditingController.fromValue(
        TextEditingValue(
            // 设置内容
            text: widget.inputText,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: widget.inputText.length))),
      );

    return TextField(
      controller: controller,
//      keyboardType:widget.keyboardType,
      decoration: InputDecoration(
        icon: ImageIcon(
          AssetImage(widget.iconStr),
          size: ScreenUtils.getScaleW(context, 25),
        ),

        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: Color.fromRGBO(170, 170, 170, 1.0),
            fontSize: 15.0,
            fontWeight: FontWeight.w400),

        //下划线样式
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(238, 238, 238, 1.0), //边线颜色为黄色
          ),
        ),

        suffixIcon: Container(
          width: ScreenUtils.getScaleW(
              context,
              widget.inputText.isEmpty
                  ? ScreenUtils.getScaleW(context, 18)
                  : ScreenUtils.getScaleW(context, 60)),
          height: ScreenUtils.getScaleW(context, 20),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.hasdeleteIcon && widget.inputText.isEmpty == false
                  ? Expanded(
                      child: IconButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        icon: Image.asset(
                          'images/clearBtn.png',
                          width: ScreenUtils.getScaleW(context, 18),
                          height: ScreenUtils.getScaleW(context, 18),
                          fit: BoxFit.fill,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.inputText = '';
                            widget.fieldCallBack('');
                          });
                        },
                      ),
                    )
                  : Container(
                      width: ScreenUtils.getScaleW(context, 18),
                      height: ScreenUtils.getScaleW(context, 18),
                    ),
              widget.hasShowPasswordIcon
                  ? Expanded(
                      child: IconButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        icon: Image.asset(
                          widget.hiddenPassword
                              ? 'images/hiddenPassword.png'
                              : 'images/lookPassword.png',
                          width: ScreenUtils.getScaleW(context, 20),
                          height: ScreenUtils.getScaleW(context, 12),
                          fit: BoxFit.fill,
                        ),
                        onPressed: () {
                          if (widget.showPassWord != null) {
                            widget.showPassWord(!widget.hiddenPassword);
                          }
                        },
                      ),
                    )
                  : Container(
                      width: ScreenUtils.getScaleW(context, 0),
                      height: ScreenUtils.getScaleW(context, 0),
                    ),
            ],
          ),
        ),
      ),
      obscureText: widget.hiddenPassword,

      onChanged: (str) {
        widget.fieldCallBack(str);
        widget.inputText = str;
        setState(() {
        });
      },
    );
  }
}
