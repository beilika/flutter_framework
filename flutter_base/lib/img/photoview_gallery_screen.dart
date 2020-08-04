import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// @author 强周亮(qiangzhouliang)
/// @desc 查看大图公共封装
/// @email 2538096489@qq.com
/// @time 2020/7/23 15:14
class PhotoViewGalleryScreen extends StatefulWidget {
  //要显示的图片列表数组
  List images=[];
  int index=0;
  String heroTag;
  PageController controller;

  PhotoViewGalleryScreen({Key key,@required this.images,this.index = 0,this.controller,this.heroTag}) : super(key: key){
    controller=PageController(initialPage: index);
  }

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen> {
  int currentIndex=0;

  @override
  void initState() {
    super.initState();
    currentIndex=widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.images[index]),
                      heroAttributes: widget.heroTag.isNotEmpty?PhotoViewHeroAttributes(tag: widget.heroTag):null,
                    );
                  },
                  itemCount: widget.images.length,
                  loadingChild: Container(),
                  backgroundDecoration: null,
                  pageController: widget.controller,
                  enableRotation: false,
                  onPageChanged: (index){
                    setState(() {
                      currentIndex=index;
                    });
                  },
                )
            ),
          ),
          Positioned(//图片index显示
            top: MediaQuery.of(context).padding.top+15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex+1}/${widget.images.length}",style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
          ),
          Positioned(//右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(Icons.close,size: 30,color: Colors.white,),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}