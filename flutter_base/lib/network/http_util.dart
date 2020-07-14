import 'package:flutter/material.dart';
import 'package:flutterbase/util/userManager.dart';

import 'api.dart';
import 'httpManager.dart';

typedef HttpSuccessCallBack(data);
typedef HttpOnErrorCallBack(error);
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