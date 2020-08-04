
import 'package:flutterbase/update/model/app_update_entity.dart';

class UserManager {
  UserModelEntity _userModel;
  AppUpdateEntity _appUpdateEntity;


  String _appVersion;

  // 单例
  factory UserManager() => _getInstance();
  static UserManager get instance => _getInstance();
  static UserManager _instance;
  UserManager._internal() {
    // 初始化
  }
  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = new UserManager._internal();
    }
    return _instance;
  }

  setUserModel(UserModelEntity userModel) {
    _userModel = userModel;
  }

  setAppUpdateEntity(AppUpdateEntity entity){
    _appUpdateEntity = entity;
  }
  getAppUpdateEntity(){
    return _appUpdateEntity;
  }



  setAppVersion(String appVersion){
    _appVersion = appVersion;
  }

  String lastestVersion(){
    if(_appUpdateEntity==null){
      return '';
    }
    return _appUpdateEntity.version==null?'':_appUpdateEntity.version;
  }

  String appVersion(){
    return _appVersion==null?'':_appVersion;
  }

  UserModelEntity getUserModel() {
    return _userModel;
  }

  String token() {
    return _userModel.newToken==null?'':_userModel.newToken;
  }
  String topDeptId(){
    return _userModel.topDeptId==null?'':_userModel.topDeptId;
  }

  String topDeptName(){
    return _userModel.topDeptName==null?'':_userModel.topDeptName;
  }

  String deptName(){
    return _userModel.deptName==null?'':_userModel.deptName;
  }

  String deptId(){
    return _userModel.deptId==null?'':_userModel.deptId;
  }

  String userName(){
    return _userModel.userName==null?'':_userModel.userName;
  }

  String headImgUrl(){
    return _userModel.headImgUrl==null?'':_userModel.headImgUrl;
  }

  String postName(){
    return _userModel.postName==null?'':_userModel.postName;
  }
}

class UserModelEntity {
  String deptName;
  String newToken;
  String deptId;
  String userName;
  String fileViewUrlPrefix;
  String userId;
  String orgId;
  String topDeptName;
  String fileDeleteUrlPrefix;
  String headImgUrl;
  String fileDownLoadUrlPrefix;
  String fileListUrlPrefix;
  String fileUploadUrlPrefix;
  String postName;
  String topDeptId;
  List<UserModelmanupermissionitemlist> menuPermissionItemList;
  String roleNames;
  List<UserModelApppermissionitemlist> appPermissionItemList;

  UserModelEntity(
      {this.deptName,
      this.newToken,
      this.deptId,
      this.userName,
      this.fileViewUrlPrefix,
      this.userId,
      this.orgId,
      this.topDeptName,
      this.fileDeleteUrlPrefix,
      this.headImgUrl,
      this.fileDownLoadUrlPrefix,
      this.fileListUrlPrefix,
      this.fileUploadUrlPrefix,
      this.postName,
      this.topDeptId,
      this.menuPermissionItemList,
      this.roleNames,
      this.appPermissionItemList});

  UserModelEntity.fromJson(Map<String, dynamic> json) {
    deptName = json['deptName'];
    newToken = json['newToken'];
    deptId = json['deptId'];
    userName = json['userName'];
    fileViewUrlPrefix = json['fileViewUrlPrefix'];
    userId = json['userId'];
    orgId = json['orgId'];
    topDeptName = json['topDeptName'];
    fileDeleteUrlPrefix = json['fileDeleteUrlPrefix'];
    headImgUrl = json['headImgUrl'];
    fileDownLoadUrlPrefix = json['fileDownLoadUrlPrefix'];
    fileListUrlPrefix = json['fileListUrlPrefix'];
    fileUploadUrlPrefix = json['fileUploadUrlPrefix'];
    postName = json['postName'];
    topDeptId = json['topDeptId'];
    if (json['menuPermissionItemList'] != null) {
      menuPermissionItemList = new List<UserModelmanupermissionitemlist>();
      (json['menuPermissionItemList'] as List).forEach((v) {
        menuPermissionItemList
            .add(new UserModelmanupermissionitemlist.fromJson(v));
      });
    }
    roleNames = json['roleNames'];
    if (json['appPermissionItemList'] != null) {
      appPermissionItemList = new List<UserModelApppermissionitemlist>();
      (json['appPermissionItemList'] as List).forEach((v) {
        appPermissionItemList
            .add(new UserModelApppermissionitemlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deptName'] = this.deptName;
    data['newToken'] = this.newToken;
    data['deptId'] = this.deptId;
    data['userName'] = this.userName;
    data['fileViewUrlPrefix'] = this.fileViewUrlPrefix;
    data['userId'] = this.userId;
    data['orgId'] = this.orgId;
    data['topDeptName'] = this.topDeptName;
    data['fileDeleteUrlPrefix'] = this.fileDeleteUrlPrefix;
    data['headImgUrl'] = this.headImgUrl;
    data['fileDownLoadUrlPrefix'] = this.fileDownLoadUrlPrefix;
    data['fileListUrlPrefix'] = this.fileListUrlPrefix;
    data['fileUploadUrlPrefix'] = this.fileUploadUrlPrefix;
    data['postName'] = this.postName;
    data['topDeptId'] = this.topDeptId;
    if (this.menuPermissionItemList != null) {
      data['menuPermissionItemList'] =
          this.menuPermissionItemList.map((v) => v.toJson()).toList();
    }
    data['roleNames'] = this.roleNames;
    if (this.appPermissionItemList != null) {
      data['appPermissionItemList'] =
          this.appPermissionItemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModelmanupermissionitemlist {
  String code;
  String name;

  UserModelmanupermissionitemlist({this.code, this.name});

  UserModelmanupermissionitemlist.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class UserModelApppermissionitemlist {
  String code;
  int orderId;
  String name;

  UserModelApppermissionitemlist({this.code, this.orderId, this.name});

  UserModelApppermissionitemlist.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    orderId = json['orderId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['orderId'] = this.orderId;
    data['name'] = this.name;
    return data;
  }
}
