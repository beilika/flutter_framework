import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @author 强周亮(qiangzhouliang)
/// @desc 自定义APPbar
/// @email 2538096489@qq.com
/// @time 2020/6/24 22:37
/// actions:<Widget>[
//        IconButton(
//            icon:Icon(Icons.search),
//            onPressed: (){
//              //调出搜索条
//              showSearch(context: context, delegate: searchBarDelegate());
//            }
//        ),
//      ]
/// tabBar:TabBar(
//              controller: _controller,
//              tabs:[
//                Tab(icon:Icon(Icons.directions_car)),
//                Tab(icon:Icon(Icons.directions_transit)),
//                Tab(icon:Icon(Icons.directions_bike)),
//              ],
//            )
//        )
Widget myAppBar(context,title,
    {isShowLead = true,
      leadingIcon = Icons.navigate_before,
      VoidCallback onPressed,
      List<Widget> actions,
      tabBar}) {
  return AppBar(
    //返回图标
    leading: isShowLead ? Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(leadingIcon),
          onPressed: onPressed == null ? () { Navigator.of(context).pop(); } : onPressed,
        );
      },
    ) : null,
    bottom: tabBar != null ? PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: Material(color: Colors.white, child: tabBar,),
    ) : null,
    //内容居中
    centerTitle: true,
    //标题
    title:Text(title,style: TextStyle(color: Colors.white,fontSize: 20.sp),),
    //右边操作栏，传递数组
    actions:actions
  );
}