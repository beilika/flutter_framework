import 'package:flutter/material.dart';
import 'package:flutterbase/base_exp.dart';

/*旅拍*/
class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  TabController _controller;

  @override
  void initState(){
    super.initState();
    _controller = TabController(length:3, vsync: this);
  }
  //重写keepAlive 为ture ，就是可以有记忆功能了。
  @override
  bool get wantKeepAlive => true;
  //重写被释放的方法，只释放TabController
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //Scaffold 实现了基本的 Material Design 布局结构
    return Scaffold(
        appBar:myAppBar(context, '旅拍',tabBar: TabBar(
          labelColor: GlobalConfig.bluefontColor,
          unselectedLabelColor: Colors.grey,
          controller: _controller,
          tabs:[
            Tab(icon:Icon(Icons.directions_car)),
            Tab(icon:Icon(Icons.directions_transit)),
            Tab(icon:Icon(Icons.directions_bike)),
          ],
        )),
        body:TabBarView(
          controller: _controller,
          children: <Widget>[
            Text('directions_car'),
            Text('directions_transit'),
            Text('directions_bike')
          ],
        )
    );
  }
}