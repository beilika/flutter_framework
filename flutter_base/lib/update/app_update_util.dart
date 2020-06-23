import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/network/api.dart';
import 'package:flutterbase/network/httpManager.dart';
import 'package:flutterbase/util/navigator_util.dart';
import 'package:flutterbase/util/userManager.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_update_diolog.dart';
import 'app_update_page.dart';
import 'model/app_update_entity.dart';

/// @author 强周亮(qiangzhouliang)

/// @desc 检查更新工具类

/// @email 2538096489@qq.com

/// @time 2020/6/22 17:12

class CheckUpdateUtil {

  BuildContext context;

  CheckUpdateUtil(this.context);

  //接口获取当前最新版本信息
  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //当前版本号
    String appVersion = packageInfo.version;

    String url = API.BE_BaseUrl+API.BE_GetVersion;

    Map<String, String> headersMap = new Map();
    headersMap["content-type"] = "application/json";
//    headersMap["Authorization"] = UserManager().token();
    //测试token
    String token =
        'eyJhbGciOiJSU0EtT0FFUC0yNTYiLCJlbmMiOiJBMTI4R0NNIn0.M00vfJ1DOHXkAXeqj2nIe1z31K8q_s9c2bIr6sA4W13YDLlfCyXQgTFBcJsNACf2kWOp5tO7XZyYsljsBwgX041iJdncs_NnFAuqCgUlbOkD4Eh_A60pyT08Zhn3NYHBo9E63aR_woftTl3WVwFySE6qXlo4fs6Bcg5g8e0Xgms.pSfuvtlBvp13k7dx.gv898p2_cwivsGbyBXFq9WuCbXUleoY5k_l-XWVWlqH5b4vqbt8v81gtkVJYjlTAJVe7Ig5U5uNJy3xOGBMTFbNd0H0CeyOjopWMSzXvbPBKunEYtMdkeYHm1-KuWM0h3Q_Cq4zuW9e6JSBXpAs4mEm-GBcW6du6vwzn2P2F1fPkQso8QY-GhbaJUWFgd8OsNXJS-APkAHBfr9ISkITu2UMXx8-6fmokEIymNwOy5jMY9e9qk3_6eQIRvu73f5rmwJJo0PkVtoPG9Qrtgg3W6nHvgQAA1GFA2sgKqiEh1bz36j9rKGL-xXv1nRk6qsSdUsSaS9KA99k9Pc_nygi0ts6tHmNYikCyLKre7TKitVfM_Q3KzNu0wM2Tkst9EPmfUyo3hvxIEUJ0v773cnJcFiQaKcHuvNSaZPzXsyGE2symjYtWcHUxX1FQARVKX9mBx58P9jxhGu-r4Am1t3DeHRisyP_PIxg82-gNrZe8greY6gWltK5fyBRLW5SKJTPY6PYr8yi0pZgXi2EbB829fMsPpfNAbRxMIySsyvFcYR_jVsWRSrA06w2SZmplBAF7eOD4qqeOVGdSaGK1mhczJ0_BaZpUudTOoVvPqU7UiE3dZNk70OS2NgdtTtGUlJsA1Qw2Wud5xvDS2T18MFflfMRavfj4M6_0vuBk3n9GR3VjqXk_JKOD296ORad09e56IrWSuB_4jwNe7M2_hE5WWxvrdhtb3hvUQtpoVMqAeUF39BKHeSSt5SpspigzznhHrfVsrKVft7ARVF1GRd7AtopTqe_GY-3aTN_46-Rt-HAT_NLF4Wq4RznTwZh_aTNA3U2sUM_GQbmrVmceLbwIIEQtzuaZPDgWn5n8nHnfkdYvYuk7HINKgySfj6zLpAYqAeKa2uTHUK42C6RCiWKcwTsbVPPBRciXaT889JTbbyXly7-JM049LqJAWlFcWtb_zzcvvOOUsOoPLL_SRly3FIFOWR2ebri69P0jdr4HHAsYdPad4LRg-ub_G6cxF8uucnyN64TZSktoL_M8EdG5Jg4EMEQ-Y81hav91nhSXIuyILz8zSNOuZ4irCQLwkTPIB32yfB8GpEz8h44dZSpSbXWwPrBAmMu6irrudJqA-w0zH3gMQd8dHW9rSCE0dlHaJETiRKjhpa7inhtkF8PjIc8wDbhn3FCtaVCSHu4OxdwZWgfEhOoorH7zcRAD9cXy0_3FwhGdhFVjkq2ItimqCnx-ACS4RLDa61DyNYM0ZN0907K5SN8Ctqo1XHNMtuJsLhzCd-WqZQRs2CNeCDsNJLsz8LbscVaiVoAG_aRveVu37GSdtX3Zf1SeU8ZJYiNu_YqAKLQ79NSa32dVQ6ShLGxfgGPKhknGl7d7v7MrooYBZnpeKFXmyztJOxZHfXtvsR2scW053MYYxbNMlOrKDiiKV3czOAnD-6Pgl6Fn6m3HeK_CuFhShjBGsJOWLdTmw5O4qnzpU7oC00o1.r5Co08hR1TbLmMxYYuiLaQ';
    headersMap["Authorization"] = token;

    HttpManager.get(url, headers: headersMap,
        onSuccess: (data) {
          if (data['success'] != null &&
              data['success'].toString().compareTo('0') == 0) {
            if (data['data'] != null && data['data'] != null) {
              Map versionData = data['data'];
              AppUpdateEntity entity = AppUpdateEntity.fromJson(versionData);
              UserManager().setAppUpdateEntity(entity);
              UserManager().setAppVersion(appVersion);
              String lastestVersion = entity.version;

              if (appVersion.compareTo(lastestVersion) != 0) {
                //当前版本不是最新版本,
                //1.先判断是否需要强制升级
//                if (entity.needForcedUpdating.compareTo('1') == 0) {
                  //需要强制升级'
                  showDialog<Null>(
                      context: context, //BuildContext对象
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return APPUpdateDialog(
                          content: entity.describe,
                          needForcedUpdating: entity.needForcedUpdating.compareTo('1') == 0,
                          doneClicked: () {
                            if (Platform.isAndroid) {
                              //测试下载应用地址
                              var testUrl = "http://60.164.243.234:20101/api/file/downloadApk?fileUrl=APK/2020-06-19/lzshzz_release_1002.apk&downloadOrUpdate=02";
                              gotoAndroidDownloadPage(testUrl);
//                              gotoAndroidDownloadPage(entity.androidUrl);
                            } else {
                              gotoAppStore(entity.iosUrl);
                            }
                          },
                        );
                      });
//                }
              }
            }
          }
        }, onError: (error) {
          print(error);
        });
  }
  //检查更新
  void checkUpdate() {
    getAppVersion();

    /*if (UserManager().appVersion().compareTo(UserManager().lastestVersion()) == 0) {
      //已经是最新版本
      _showLatestVersionDialog();
    } else {
      //版本升级,
      AppUpdateEntity entity = UserManager().getAppUpdateEntity();
      showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return APPUpdateDialog(
            content: entity.describe,
            needForcedUpdating: false,
            doneClicked: () {
              if (Platform.isAndroid) {
                gotoAndroidDownloadPage(entity.androidUrl);
              } else {
                gotoAppStore(entity.iosUrl);
              }
            },
          );
        });
    }*/
  }

  void _showLatestVersionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('当前已是最新版本'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  gotoAndroidDownloadPage(String url){
    NavigatorUtil.push(context, AppUpdatePage(androidUrl: url,));
  }

  gotoAppStore(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
