import 'package:flutter/material.dart';
import 'package:flutter_framework/pages/home_page.dart';
import 'package:flutter_framework/pages/my_page.dart';
import 'package:flutter_framework/pages/search_page.dart';
import 'package:flutter_framework/pages/travel_page.dart';
//选中的颜色和未选中的颜色
final _defaultColor = Colors.grey;
final _activeColor = Colors.blue;
//当前选中值
int _currentIndex = 0;
/*导航栏组件，继承自有状态的组件 StatefulWidget*/
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}
/*_:可以定义为私有类，不被外界访问*/
class _TabNavigatorState extends State<TabNavigator> {
  //首页, 搜索, 旅拍, 我的
  List<Widget> _listPage = [HomePage(), SearchPage(), TravelPage(), MyPage(),];

  final PageController _controller = PageController(initialPage: 0,);

  @override
  Widget build(BuildContext context) {
    //Scaffold 实现了基本的 Material Design 布局结构和手机屏幕适配
    return Scaffold(
      body: PageView(
        controller: _controller,
        //禁止滑动
//        physics: NeverScrollableScrollPhysics(),
        //页面改变的时候
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        // 这个里面就是要显示的界面
        children: _listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        //设置当前选中的是哪一个
        currentIndex: _currentIndex,
        //点击改变状态值
        onTap: _onTab,
        //将label固定，无论选中不选择，让字体都显示出来
        type: BottomNavigationBarType.fixed,

        items: [
          _bootomItem('首页',Icons.home,0),
          _bootomItem('搜索',Icons.search,1),
          _bootomItem('旅拍',Icons.camera_alt,2),
          _bootomItem('我的',Icons.home,3),
        ],
      ),
    );
  }

  //点击事件
  _onTab(index){
    //设置当前选中页面
    _controller.jumpToPage(index);
    //在这里面改变状态值
    setState(() {
      _currentIndex = index;
    });
  }
}

//底部显示样式封装
BottomNavigationBarItem _bootomItem(String title,IconData icon,int index){
  return BottomNavigationBarItem(
      icon: Icon(icon,color: _defaultColor,),
      activeIcon: Icon(icon,color: _activeColor,),
      title: Text(title,style: TextStyle(color:_currentIndex !=index ? _defaultColor : _activeColor),)
  );
}

