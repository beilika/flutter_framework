import 'package:flutter_cipher/flutter_cipher.dart';
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
void main(){
  var encrypted = AesUtil.aesEncrypt("ADMIN");
  print(encrypted);

//  var content = aes.decrypt(encrypted);
  var content = AesUtil.aesDecrypt(encrypted);
  print(content);
}