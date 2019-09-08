import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_framework/pages/home_page.dart';
import 'package:flutter_framework/pages/my_page.dart';
import 'package:flutter_framework/pages/search_page.dart';
import 'package:flutter_framework/util/navigator_util.dart';
/*不规则底部导航*/
class MyBottomAppBar extends StatefulWidget {
  @override
  _MyBottomAppBarState createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  List<Widget> _eachView;  //创建视图数组
  int _index = 0;          //数组索引，通过改变索引值改变视图

  @override
  void initState() {
    super.initState();
    _eachView = List();
    _eachView..add(HomePage())..add(MyPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_eachView[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //带有平滑切换效果的路由
          NavigatorUtil.pushRightBack(context, SearchPage());
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      //写完这些代码已经有了一个悬浮的按钮，但这个悬浮按钮还没有和低栏进行融合，这时候需要一个属性。
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color:Colors.lightBlue,
        shape:CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon:Icon(Icons.home),
                color:Colors.white,
                onPressed:(){
                  setState(() {
                    _index=0;
                  });
                }
            ),
            IconButton(
                icon:Icon(Icons.settings),
                color:Colors.white,
                onPressed:(){
                  setState(() {
                    _index=1;
                  });
                }
            ),
          ],
        ),
      ),
    );
  }
}
