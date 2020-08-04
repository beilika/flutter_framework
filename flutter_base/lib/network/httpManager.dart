import 'package:flutterbase/base_exp.dart';
import 'package:flutterbase/util/aes_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpManager {

  static const int CONNECT_TIMEOUT = 10;

  static void get(String url,{headers, Function onSuccess,
      Map<String, dynamic> params, Function onError}) async {
    if (params != null && params.isNotEmpty) {
      //参数加密
      if(GlobalConfig.isEncryPara && GlobalConfig.passUrl.indexOf(url) < 0){
        params = AesEncryptParam(params);
      }

      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(url,headers: headers).timeout(Duration(seconds: CONNECT_TIMEOUT));
      if (onSuccess != null) {
        onSuccess(json.decode(res.body));
      }
    } catch (exception) {
      if (onError != null) {
        onError(exception);
      }
    }
  }

  static void post(String url, {headers, bodys, Function onSuccess, Function onError}) async {
    //参数加密
    if(GlobalConfig.isEncryPara && GlobalConfig.passUrl.indexOf(url) < 0){
      bodys = AesEncryptParam(bodys);
    }

    try {
      http.Response res =
          await http.post(url, headers: headers, body: jsonEncode(bodys),encoding:Utf8Codec()).timeout(Duration(seconds: CONNECT_TIMEOUT));
      if (onSuccess != null) {
        onSuccess(json.decode(res.body));
      }
    } catch (error) {
      if (onError != null) {
        onError(error);
      }
    }
  }
}

