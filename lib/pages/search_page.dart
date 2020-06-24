import 'package:flutter/material.dart';
import 'package:flutter_framework/widget/search_bar_delegate.dart';

/*搜索页面*/
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    //Scaffold 实现了基本的 Material Design 布局结构
    return Scaffold(
        appBar:AppBar(
          centerTitle: true,
          title:Text('SearchBarDemo'),
          actions:<Widget>[
            IconButton(
                icon:Icon(Icons.search),
                onPressed: (){
                  //调出搜索条
                  showSearch(context: context, delegate: searchBarDelegate());
                  print('开始搜索');
                }
            ),
          ]
        ),
      body: Center(
        child: Text('搜索'),
      ),
    );
  }
}