import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutterbase/base_exp.dart';
import 'package:flutterbase/dialog/common_diolog.dart';
import 'package:flutterbase/img/photoview_gallery_screen.dart';
import 'package:flutterbase/network/api.dart';
import 'package:flutterbase/permission/permission_util.dart';
import 'package:flutterbase/util/navigator_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'file_reader_page.dart';

/// @author 强周亮(qiangzhouliang)
/// @desc 文件下载公共方法
/// @email 2538096489@qq.com
/// @time 2020/7/23 15:53
class FileDownload{
  ProgressDialog pr;
  ReceivePort _port = ReceivePort();
  var _filePath;
  var _fileName;
  BuildContext _context;

  doDownloadOperation(BuildContext context,{@required String filePathAll,@required fileName}) async {
    _context = context;
    _bindBackgroundIsolate();
    flutterDownloaderInit();
    pr = ProgressDialog(context, type: ProgressDialogType.Download);
    pr.update(message: '下载中…');
    /**
     * 下载文件的步骤：
     * 1. 查看路径下文件是否存在,若存在,则直接打开,不存在,下载再下载打开
     * 2. 获取权限：网络权限、存储权限
     * 3. 获取下载路径
     * 4. 设置下载回调
     */
    var _localPath = (await _findLocalPath(context)) + '/Download';

    final savedDir = Directory(_localPath);
    // 判断下载路径是否存在
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      print(_localPath);
      savedDir.create();
    }

    File filePath = File('${_localPath}/${fileName}');
    print(filePath.path);
    //判断文件是否已经存在
    var haveDown = await filePath.exists(); //返回真假
    _filePath = filePath.path;
    _fileName = fileName;

    //先判断是不是图片
    if(fileName.endsWith('.png') || fileName.endsWith('.jpg') || fileName.contains('.jpeg')){
      var imgUrl = API.BE_BaseUrl+"/${filePathAll}";
      if(filePathAll.startsWith("http://") || filePathAll.startsWith("https://")){
        imgUrl = filePathAll;
      }
      NavigatorUtil.push(
          context,
          PhotoViewGalleryScreen(
            images: [imgUrl],
            heroTag: fileName,
          ));
      return;
    }

    if (haveDown) {
      LogUtil.d('文件存在');
      pr.hide();
      NavigatorUtil.push(context, FileReaderPage(filePath: _filePath, fileName: fileName,));
    } else {
      LogUtil.d('文件不存在');
      CommonDialog.show(context,"在使用查看文件功能前，您先需要授予读写手机存储的权限，否则，您将无法使用该功能！",doneClicked: (){
        PermissionUtil(success: (){
          // 下载链接
          String downloadUrl = API.BE_BaseUrl+ filePathAll;
          if(filePathAll.startsWith("http://") || filePathAll.startsWith("https://")){
            downloadUrl = filePathAll;
          }
          // 下载
          _downloadFile(downloadUrl, _localPath, fileName);
        }).requestPermission([Permission.storage]);
      });
    }
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.running) {
        pr.update(progress: progress.toDouble(), message: "下载中，请稍后…");
//        print('下载中---${progress.toDouble()}');
      }
      if (status == DownloadTaskStatus.failed) {
        MyToast.toast(msg: "下载异常，请稍后重试");

        pr.hide();
      }
      if (status == DownloadTaskStatus.complete) {
        pr.hide();
        NavigatorUtil.push(_context, FileReaderPage(filePath: _filePath, fileName: _fileName,));
      }
    });
  }

  // 根据 downloadUrl 和 savePath 下载文件
  _downloadFile(downloadUrl, savePath, String fileName) async {
    pr.show();
    await FlutterDownloader.enqueue(
      url: downloadUrl,
      savedDir: savePath,
      fileName: fileName,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
      true, // click on notification to open downloaded file (for Android)
    );
  }

  // 获取存储路径
  Future<String> _findLocalPath(BuildContext context) async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    return directory.path;
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  flutterDownloaderInit() async {
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
}