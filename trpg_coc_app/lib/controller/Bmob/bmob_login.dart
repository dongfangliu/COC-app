import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_sms.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_sent.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:trpgcocapp/ui/pages/login/login_page.dart';
class BmobLogin{
  String appId = 'c0e5dbfe38a164ba90d2c4c7e1c846a9';
  String apiKey = '6fc3e0520028a3a095ebb8aa1097c10e';
  String appHost = 'https://api2.bmob.cn';

  BmobLogin(){
    Bmob.init(appHost, appId, apiKey);
  }

  // region For phone SMS login
  Future<LoginMsgs> sendSMS (String phone) async {
    BmobSms bmobSms = new BmobSms();
    bmobSms.mobilePhoneNumber = phone;
    try {
      BmobSent result = await bmobSms.sendSms();
    } catch (e) {
      print(BmobError.convert(e));
      int errorCode = BmobError.convert(e).code;
      switch (errorCode) {
        case 301: {
          return LoginMsgs.WrongPhoneFormat;
        }
        break;
        case 9015: {
          return LoginMsgs.NetworkFailure;
        }
        break;
        default:{
          return LoginMsgs.UnknownFailure;
        }
        break;
      }
    }
    return LoginMsgs.SMSSent;
  }
  Future<LoginMsgs> loginBySMS(String phone, String code) async {
    BmobUser bmobUser = BmobUser();
    bmobUser.mobilePhoneNumber = phone;
    bmobUser.password = 'password';
    try {
      BmobUser result = await bmobUser.loginBySms(code);
      // print(result);
    } catch (e) {
      print(BmobError.convert(e));
      int errorCode = BmobError.convert(e).code;
      switch (errorCode) {
        case 207: {
          return LoginMsgs.VerifyCodeWrong;
        }
        break;
        case 9015: {
          return LoginMsgs.NetworkFailure;
        }
        break;
        default:{
          return LoginMsgs.UnknownFailure;
        }
        break;
      }
    }
    print(bmobUser.password);
    return LoginMsgs.LoginSuccess;
  }
  // endregion

  // region For password login
  Future<LoginMsgs> loginByPWD(String username, String password) async {
    BmobUser bmobUser = BmobUser();
    bmobUser.username = username;
    bmobUser.password = password;
    try {
      BmobUser result = await bmobUser.login();
    } catch (e) {
      print(BmobError.convert(e));
      int errorCode = BmobError.convert(e).code;
      switch (errorCode) {
        case 101: {
          return LoginMsgs.InfoIncorrect;
        }
        break;
        case 9015: {
          return LoginMsgs.NetworkFailure;
        }
        break;
        default:{
          return LoginMsgs.UnknownFailure;
        }
        break;
      }
    }
    return LoginMsgs.LoginSuccess;
  }
  // endregion
}