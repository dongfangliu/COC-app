import 'dart:convert';
import 'dart:io';

import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_dio.dart';
import 'package:data_plugin/bmob/bmob_file_manager.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/bmob_sms.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/bmob/response/bmob_sent.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import 'package:trpgcocapp/bloc/login/login_result.dart';
import 'package:trpgcocapp/data/app_user.dart';

class UserConnector {
  static final String _appId = 'c0e5dbfe38a164ba90d2c4c7e1c846a9';
  static final String _apiKey = '6fc3e0520028a3a095ebb8aa1097c10e';
  static final String _appHost = 'https://api2.bmob.cn';

  static void _bmobInit() { Bmob.init(_appHost, _appId, _apiKey); }

  static Future<AppUser> getUserByObjectID (String objectID) async {
    _bmobInit();
    AppUser currentUser;

    BmobQuery bmobQuery = BmobQuery();
    var data = await bmobQuery.queryObjectByTableName(objectID, "_User");
    currentUser = AppUser.fromJSON(data);
    return currentUser;
  }

  static Future<LoginResultMsgs> sendSMS (String phone) async {
    _bmobInit();
    BmobSms bmobSms = new BmobSms();
    bmobSms.mobilePhoneNumber = phone;
    try {
      BmobSent result = await bmobSms.sendSms();
      return LoginResultMsgs.SMSSent;
    } catch (e) {
      // print(BmobError.convert(e));
      int errorCode = BmobError.convert(e).code;
      switch (errorCode) {
        case 301: {
          return LoginResultMsgs.WrongPhoneFormat;
        }
        break;
        case 9015: {
          return LoginResultMsgs.NetworkFailure;
        }
        break;
        default:{
          print(BmobError.convert(e));
          return LoginResultMsgs.UnknownFailure;
        }
        break;
      }
    }
  }
  static Future<LoginResult> loginBySMS(String phone, String code) async {
    _bmobInit();
    String data = "{\"smsCode\":\"$code\",\"mobilePhoneNumber\":\"$phone\"}";
    try {
      Map result = await BmobDio.getInstance().post(Bmob.BMOB_API_USERS, data: data);
      AppUser currentUser = AppUser.fromJSON(result);
      return LoginResult(LoginResultMsgs.LoginSuccess, currentUser);
    } catch (e) {
      int errorCode = BmobError.convert(e).code;
      switch (errorCode) {
        case 207: {
          return LoginResult(LoginResultMsgs.VerifyCodeWrong, null);
        }
        break;
        case 9015: {
          return LoginResult(LoginResultMsgs.NetworkFailure, null);
        }
        break;
        default:{
          print(BmobError.convert(e));
          return LoginResult(LoginResultMsgs.UnknownFailure, null);
        }
        break;
      }
    }
  }

  static Future<LoginResult> loginByPWD (String username, String password) async {
    _bmobInit();
    String urlParams = "?username=$username&password=$password";
    try {
      Map result = await BmobDio.getInstance().get(Bmob.BMOB_API_LOGIN + urlParams);
      AppUser currentUser = AppUser.fromJSON(result);
      return LoginResult(LoginResultMsgs.LoginSuccess, currentUser);
    } catch (e) {
      int errorCode = BmobError.convert(e).code;
      switch (errorCode) {
        case 101: {
          return LoginResult(LoginResultMsgs.InfoIncorrect, null);
        }
        break;
        case 9015: {
          return LoginResult(LoginResultMsgs.NetworkFailure, null);
        }
        break;
        default:{
          print("Login Unknown Error: " + BmobError.convert(e).toString());
          return LoginResult(LoginResultMsgs.UnknownFailure, null);
        }
        break;
      }
    }
  }

  static Future<BmobUpdated> updateUser (AppUser appUser) async {
    _bmobInit();
    String params = json.encode(appUser.toMap());
    String tableName = "_User";
    String objectId = appUser.bmobObjectID;
    Map responseData = await BmobDio.getInstance().put(
        Bmob.BMOB_API_CLASSES + tableName + Bmob.BMOB_API_SLASH + objectId,
        data: params);
    BmobUpdated bmobUpdated = BmobUpdated.fromJson(responseData);
    return bmobUpdated;
  }

  static void updateAvatar(AppUser appUser, String filePath) async {
    _bmobInit();
    String oldAvatarUrl = appUser.avatar.url;

    File avatarFile = File(filePath);
    BmobFileManager.upload(avatarFile).then((avatarFile){
      appUser.avatar = avatarFile;
      print("avatar: " + appUser.avatar.toString());
      updateUser(appUser).then((_){
        print("Avatar saved to _User table");

        // Delete the old avatar
        String domain = "files.trpgol.cn";
        int indexDomain = oldAvatarUrl.indexOf(domain);
        int indexHead = indexDomain + domain.length;
        int indexTail = oldAvatarUrl.length;
        String fileUrl = oldAvatarUrl.substring(indexHead, indexTail);
        String path = "${Bmob.BMOB_API_FILE_VERSION}${Bmob.BMOB_API_FILE}/files.trpgol$fileUrl";
        BmobDio.getInstance().delete(path).then((responseData){
          BmobHandled bmobHandled = BmobHandled.fromJson(responseData);
        }).catchError((e){ print(BmobError.convert(e)); });
      }).catchError((e){ print(BmobError.convert(e));} );
    }).catchError((e){ print(BmobError.convert(e)); });
  }
}