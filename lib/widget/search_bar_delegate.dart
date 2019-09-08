import 'package:flutter/material.dart';
import 'package:flutter_framework/data/asset.dart';
/*搜索框*/
class searchBarDelegate extends SearchDelegate<String> {
  //右侧的图标
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear),onPressed: () => query = "",)
    ];
  }

  //右边的图标
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      //带动画的图标
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      //点击图标，关闭页面
      onPressed: () => close(context, null)
    );
  }

  ///搜索完返回的内容
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  //提示性文字
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentSuggest : searchList.where((input) => input.startsWith(query)).toList();
    //动态列表
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) =>
        //列表瓦片
        ListTile(
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              //把搜索到的加粗
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                //没有搜索到的变灰色
                TextSpan(text: suggestionList[index].substring(query.length), style: TextStyle(color: Colors.grey))
              ]
            )
          ),
        )
    );
  }
}
