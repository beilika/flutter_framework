import 'package:flutter/material.dart';
import 'package:flutterbase/util/userManager.dart';

import 'api.dart';
import 'httpManager.dart';
///请求成功时的接口回调
typedef HttpSuccessCallBack(data);
/// 请求失败时的接口回调
typedef HttpOnErrorCallBack(error);

/// @author 强周亮(qiangzhouliang)
/// @desc http请求工具类封装
/// @email 2538096489@qq.com
/// @time 2020/7/31 09:15
class HttpUtil {
  final HttpSuccessCallBack onSuccess;
  final HttpOnErrorCallBack onError;

  HttpUtil({@required this.onSuccess, @required this.onError});
  post(bodyParams, {@required loadUrl}) async {
    String url = API.BE_BaseUrl + loadUrl;
    Map<String, String> headersMap = new Map();
    headersMap["content-type"] = "application/json";
    headersMap["Authorization"] = UserManager().token();
    HttpManager.post(url, bodys: bodyParams,
      headers: headersMap,
      onSuccess: (data) {
        if(onSuccess != null) {
          onSuccess(data);
        }
      },
      onError: (error) {
        if(onError != null) {
          onError(error);
        }
      }
    );
  }

  get(bodyParams, {@required loadUrl}) async {
    String url = API.BE_BaseUrl + loadUrl;
    Map<String, String> headersMap = new Map();
    headersMap["content-type"] = "application/json";
    headersMap["Authorization"] = UserManager().token();
    HttpManager.get(url, params: bodyParams,
      headers: headersMap,
      onSuccess: (data) {
        if(onSuccess != null) {
          onSuccess(data);
        }
      },
      onError: (error) {
        if(onError != null) {
          onError(error);
        }
      }
    );
  }
}