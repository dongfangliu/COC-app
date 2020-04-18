import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_sms.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_registered.dart';
import 'package:data_plugin/bmob/response/bmob_sent.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import '../../ui/login_page.dart';

class BmobLogin{
  String appId = 'c0e5dbfe38a164ba90d2c4c7e1c846a9';
  String apiKey = '6fc3e0520028a3a095ebb8aa1097c10e';
  String appHost = 'https://api2.bmob.cn';

  BmobLogin(){
    Bmob.init(appHost, appId, apiKey);
  }

  Future<loginMsgs> sendSMS (String phone) async {
    BmobSms bmobSms = new BmobSms();
    bmobSms.mobilePhoneNumber = phone;
    try {
      BmobSent result = await bmobSms.sendSms();
    } catch (e) {
      print(BmobError.convert(e));
      int errorCode = BmobError.convert(e).code;
      switch (errorCode) {
        case 301: {
          return loginMsgs.SignUp_WrongPhoneFormat;
        }
        case 9015: {
          return loginMsgs.NetworkFailure;
        }
        break;
        case 207: {
          return loginMsgs.SignUp_VerifyCodeWrong;
        }
        default:{
          return loginMsgs.UnknownFailure;
        }
        break;
      }
    }
    return loginMsgs.SignUp_SMSSent;
  }

  Future<loginMsgs> signUp (String name, String phone, String verifyCode, String pwd) async {
    // Get account information
    BmobUser bmobUserRegister = new BmobUser();
    // bmobUserRegister.username = name;
    bmobUserRegister.mobilePhoneNumber = phone;
    // bmobUserRegister.password = pwd;

    // Check verify code
    try {
      BmobUser result = await bmobUserRegister.loginBySms(verifyCode);
    } catch (e) {
      print(BmobError.convert(e));
      int errorCode = BmobError.convert(e).code;
      switch (errorCode) {
        case 202: {
          return loginMsgs.SignUp_UsernameUsed;
        }
        break;
        case 9015: {
          return loginMsgs.NetworkFailure;
        }
        break;
        default:{
          return loginMsgs.UnknownFailure;
        }
        break;
      }
    }

    // Start register
    /*try {
      BmobRegistered result = await bmobUserRegister.register();
    } catch (e){
      print(BmobError.convert(e));
      int errorCode = BmobError.convert(e).code;
      switch (errorCode){
        case 202: {
          return loginMsgs.SignUp_UsernameUsed;
        }
        break;
        case 209: {
          return loginMsgs.SignUp_MobileUsed;
        }
        break;
        case 9015: {
          return loginMsgs.NetworkFailure;
        }
        break;
        default:{
          return loginMsgs.UnknownFailure;
        }
        break;
      }
    }
    return loginMsgs.SignUp_SignUpSuccess;*/
  }

  Future<loginMsgs> login (String username, String password) async {
    BmobUser bmobUserLogin = new BmobUser();
    bmobUserLogin.username = username;
    bmobUserLogin.password = password;
    try {
      BmobUser result = await bmobUserLogin.login();
    } catch (e) {
      print(BmobError.convert(e));
    }
  }
}