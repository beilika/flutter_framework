import 'package:permission_handler/permission_handler.dart';

/// @author 强周亮(qiangzhouliang)

/// @desc 动态权限申请工具类

/// @email 2538096489@qq.com

/// @time 2020/6/23 18:23

class PermissionUtil {
  final Success success;
  final Fail fail;

  PermissionUtil({this.success,this.fail});
  Future requestPermission(List<Permission> perms) async {
    // 申请权限[Permission.storage,Permission.camera]
    Map<Permission, PermissionStatus> statuses = await perms.request();
    var totalGranted = 0;
    statuses.forEach((key, value) async {
      if (value == PermissionStatus.granted) {
        totalGranted++;
        if(totalGranted >= statuses.length) {
          //权限申请成功
          success();
        }
      } else {
        //    只有当用户同时点选了拒绝开启权限和不再提醒后才会true
        if(await key.isPermanentlyDenied) {
          await openAppSettings();
        } else {
          if(await key.isGranted){
            success();
          }else{
            fail();
          }
        }
      }
    });
  }
}
//注意 typedef 需要放在class外面
//权限申请成功
typedef void Success();
//权限申请失败
typedef void Fail();
