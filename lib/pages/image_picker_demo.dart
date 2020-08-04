import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterbase/common/my_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
/*相册*/
  _openGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
    print('相册返回：' + image.toString());
  }

/*选取视频*/
  _getVideo() async {
    var image = await picker.getVideo(source: ImageSource.gallery);
    print('选取视频：' + image.toString());
  }
/*拍摄视频*/
  _takeVideo() async {
    var image = await picker.getVideo(source: ImageSource.camera);
    print('拍摄视频：' + image.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, '拍照和拍摄视频'),
      body: ListView(
        children: [
          Center(child: _image == null ? Text('No image selected.') : Image.file(_image,height: 250.0,),),
          RaisedButton(
            onPressed: _openGallery,
            child: Text("选择照片"),
          ),
          RaisedButton(
            onPressed: _getVideo,
            child: Text("选择视频"),
          ),
          RaisedButton(
            onPressed: _takeVideo,
            child: Text("拍摄视频"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

