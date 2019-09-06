import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
/// 轮播图组件
class MySwiper extends StatelessWidget {
  List imageUrls;

  MySwiper({Key key,@required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //导航栏 Opacity包裹，可以改变组件透明度
    return Container(
      height: 160,
      //Swiper 轮播图组件
      child: Swiper(
        itemCount: imageUrls.length, // 条目个数
        autoplay: true, //自动播放
        itemBuilder: (BuildContext context,index){
          //返回一个图片
          return Image.network(
            imageUrls[index],
            fit: BoxFit.fill,//适配方式，填充父窗体
          );
        },
        //添加指示器
        pagination: SwiperPagination(),
      ),
    );
  }
}
