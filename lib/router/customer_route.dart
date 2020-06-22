import 'package:flutter/material.dart';

enum CustomerRouteState {
  fade,//渐变
  scale, //缩放
  slide, //左右滑动
  rotation //旋转缩放
}
/*炫酷的跳转路由*/
class CustomerRoute extends PageRouteBuilder{
  final Widget widget;
  CustomerRoute(this.widget,{CustomerRouteState state = CustomerRouteState.slide}) :super(
      //设置动画持续的时间，建议再1和2之间。
      transitionDuration:const Duration(seconds:1),
      pageBuilder:(BuildContext context, Animation<double> animation1, Animation<double> animation2)=> widget,
      //构建动画效果
      transitionsBuilder:(BuildContext context, Animation<double> animation1, Animation<double> animation2, Widget child) {
        if(state == CustomerRouteState.fade) {
          return _fadeTransition(animation1, child);
        } else if(state == CustomerRouteState.scale){
          return _scaleTransition(animation1, child);
        } else if(state == CustomerRouteState.rotation){
          return _rotationTransition(animation1, child);
        } else {
          return _slideTransition(animation1, child);
        }
      }
  );

  //渐隐渐现过渡效果，主要设置opactiy（透明度）属性，值是0.0-1.0。
  static FadeTransition _fadeTransition(Animation<double> animation1, Widget child) {
    return FadeTransition(
      //animate :动画的样式，一般使用动画曲线组件（CurvedAnimation）。
      opacity: Tween(begin:0.0,end :1.0).animate(
        CurvedAnimation(
          parent:animation1,
          // 设置动画的节奏，也就是常说的曲线，Flutter准备了很多节奏，通过改变动画取消可以做出很多不同的效果。
          curve:Curves.fastOutSlowIn
        )
      ),
      child: child,
    );
  }
  ///缩放路由动画
  static ScaleTransition _scaleTransition(Animation<double> animation1, Widget child){
    return ScaleTransition(
        scale:Tween(begin:0.0,end:1.0).animate(CurvedAnimation(
            parent:animation1,
            curve: Curves.fastOutSlowIn
        )),
        child:child
    );
  }
  ///旋转+缩放路由动画
  static RotationTransition _rotationTransition(Animation<double> animation1, Widget child){
    return RotationTransition(
        turns:Tween(begin:0.0,end:1.0)
            .animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.fastOutSlowIn
        )),
        child:ScaleTransition(
          scale:Tween(begin: 0.0,end:1.0)
              .animate(CurvedAnimation(
              parent: animation1,
              curve:Curves.fastOutSlowIn
          )),
          child: child,
        )
    );
  }
  ///左右滑动路由动画 - 幻灯片路由动画
  static SlideTransition _slideTransition(Animation<double> animation1, Widget child){
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(-1.0, 0.0),end:Offset(0.0, 0.0))
          .animate(CurvedAnimation(
            parent: animation1,
            //快出 慢进
            curve: Curves.fastOutSlowIn
          )
      ),
      child: child,
    );
  }
}