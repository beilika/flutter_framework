import 'package:flutter_cipher/flutter_cipher.dart';

/// @author 强周亮(qiangzhouliang)
/// @desc aes 加密工具
/// @email 2538096489@qq.com
/// @time 2020/7/31 10:14
class AesUtil{
  static Symmetry _aes;
  static initAes({keys = '5ouxll40qr9uv9kz',mode = AESMode.ecb, padding = 'PKCS7'}){
    Key key = Key.fromUtf8(keys);
    _aes = Cipher.getSymmetryInstance(AES(key,mode: mode,padding: padding));
  }
  static String aesEncrypt(String str){
    if(_aes == null){
      initAes();
    }
    return _aes?.encryptString(str)?.base64;
  }
  static String aesDecrypt(String str){
    if(_aes == null){
      initAes();
    }
    return _aes.decrypt2String(Encrypted.fromBase64(str));
  }
}

/// @desc 参数加密解密方法
/// @author 强周亮
/// @time 2020/7/31 10:10
/// isEncOrDec true 表示加密 false 表示解密,默认加密
Map<String, dynamic> AesEncryptParam(Map<String, dynamic> paraMap,{isEncOrDec = true}) {
  Map<String, dynamic> resMap = {};
  paraMap.forEach((key, value) {
    if(value is String){
      resMap[key] = isEncOrDec ? AesUtil.aesEncrypt(value) : AesUtil.aesDecrypt(value);
    } else if(value is Map){
      resMap[key] = AesEncryptParam(value,isEncOrDec: isEncOrDec);
    } else if(value is List){
      var list = [];
      value.forEach((element) {
        list.add(isEncOrDec ? AesUtil.aesEncrypt(element) : AesUtil.aesDecrypt(element));
      });
      resMap[key] = list;
    }
  });
  return resMap;
}

void main(){
  var encrypted = AesUtil.aesEncrypt("ADMIN");
  print(encrypted);

//  var content = aes.decrypt(encrypted);
  var content = AesUtil.aesDecrypt(encrypted);
  print(content);

  var testMap = {
    "test1":"test1",
    "testObj":{
      "testObj1":"testObj1",
      "testObj2":"testObj2",
    },
    "testList":["1","2","3"]
  };
  var ressMap = AesEncryptParam(testMap);
  var docMap = AesEncryptParam(ressMap,isEncOrDec: false);
  print(testMap);
  print(ressMap);
  print(docMap);
}
