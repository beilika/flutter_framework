import 'package:flutter/material.dart';
import 'package:flutterbase/util/screen_utils.dart';

typedef void LoginStateToolCallBack(bool autoLoginBtnSelected,bool rememberPasswordBtnSelected);

class LoginStateTool extends StatefulWidget {
  bool autoLoginBtnSelected;
  bool rememberPasswordBtnSelected;
  final LoginStateToolCallBack btnClicked;

  LoginStateTool({
    Key key,
    this.autoLoginBtnSelected: false,
    this.rememberPasswordBtnSelected: false,
    this.btnClicked,
  }) : super(key: key);

  void _setBtnState(bool autoLoginBtnSelected,bool rememberPasswordBtnSelected){
      this.autoLoginBtnSelected = autoLoginBtnSelected;
      this.rememberPasswordBtnSelected = rememberPasswordBtnSelected;
  }

  @override
  _LoginStateToolState createState() => _LoginStateToolState();
}

class _LoginStateToolState extends State<LoginStateTool> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          child: LoginStateButton(
            buttonTitle: '自动登录',
            selected: widget.autoLoginBtnSelected,
            btnClicked: (isSelected){
              if(isSelected){
                setState(() {
                  widget.autoLoginBtnSelected = true;
                  widget.rememberPasswordBtnSelected = true;
                });
              }else{
                setState(() {
                  widget.autoLoginBtnSelected = false;
                });
              }
              widget.btnClicked(widget.autoLoginBtnSelected,widget.rememberPasswordBtnSelected);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(0.0),
          child: LoginStateButton(
            buttonTitle: '记住密码',
            selected: widget.rememberPasswordBtnSelected,
            btnClicked: (isSelected){
              if(!isSelected){
                setState(() {
                  widget.autoLoginBtnSelected = false;
                  widget.rememberPasswordBtnSelected = false;
                });
              }else{
                setState(() {
                  widget.rememberPasswordBtnSelected = true;
                });
              }
              widget.btnClicked(widget.autoLoginBtnSelected,widget.rememberPasswordBtnSelected);
            },
          ),
        ),
      ],
    );
  }

  void _setBtnState(bool autoLoginBtnSelected,bool rememberPasswordBtnSelected){
    setState(() {
      widget.autoLoginBtnSelected = autoLoginBtnSelected;
      widget.rememberPasswordBtnSelected = rememberPasswordBtnSelected;
    });
  }
}


typedef void LoginStateButtonCallBack(bool isSelected);

class LoginStateButton extends StatefulWidget {

  String buttonTitle;
  bool selected;
  final LoginStateButtonCallBack btnClicked;

  LoginStateButton({
    Key key,
    this.buttonTitle = '',
    this.selected: false,
    this.btnClicked,
  }) : super(key: key);

  @override
  _LoginStateButtonState createState() => _LoginStateButtonState();
}

class _LoginStateButtonState extends State<LoginStateButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
        icon: Image.asset(
          widget.selected?'images/loginStateBtn_selected.png':'images/loginStateBtn_unselected.png',
          width: ScreenUtils.getScaleW(context, 16),
          height: ScreenUtils.getScaleW(context, 16),
          fit: BoxFit.contain,
        ),
        elevation:0,
        color: Colors.white,
        label: Text(widget.buttonTitle,
            style: TextStyle(
                fontSize: 13.0, color: Color.fromRGBO(170, 170, 170, 1.0))),

        onPressed: () {
            widget.selected = !widget.selected;
            widget.btnClicked(widget.selected);
        });
  }
}
