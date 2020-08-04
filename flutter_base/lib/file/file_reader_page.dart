import 'package:flutter/material.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:flutter_screenutil/screenutil.dart';

class FileReaderPage extends StatefulWidget {
  final String filePath;
  final String fileName;

  FileReaderPage({Key: Key, this.filePath, this.fileName});

  @override
  _FileReaderPageState createState() => _FileReaderPageState();
}

class _FileReaderPageState extends State<FileReaderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
      ),
      body: Container(
        width: ScreenUtil.screenWidth,
        child: FileReaderView(
          filePath: widget.filePath,
        ),
      ),
    );
  }
}
