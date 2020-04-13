import '../../../ui/login_page.dart';
import 'package:leancloud_storage/leancloud.dart';
/*
enum loginMsgs {
  Login_LoginSuccess,
  Login_NotLoggedIn,
  Login_NotRegistered,
  Login_WrongPWD,
  Login_TryLater,
  SignUp_UsernameUsed,
  SignUp_MobileUsed,
  SignUp_SignUpSuccess,
}*/
class LeanCloudLogin{
  // LeanCloud Setup Information
  String _appID = 'mscpCUgWqeI2RdYhrkgHF4ab-gzGzoHsz';
  String _appKey = 'Iy6NnNNybR7SPMNG06pknoY2';
  String _server = 'https://mscpcugw.lc-cn-n1-shared.com';

  LeanCloudLogin(){
    LeanCloud.initialize(_appID, _appKey, server: _server);
    LCLogger.setLevel(LCLogger.DebugLevel);
  }

  Future<loginMsgs> login(String phone, String pwd) async {
    try {
      LCUser result = await LCUser.loginByMobilePhoneNumber(phone, pwd);
    } on LCException catch (e){
      switch (e.code){
        case 210: {
          return loginMsgs.Login_WrongPWD;
        }
        break;
        case 219: {
          return loginMsgs.Login_TryLater;
        }
        break;
        case 211: {
          return loginMsgs.Login_NotRegistered;
        }
        break;
        default: {
          return loginMsgs.Login_NotLoggedIn;
        }
      }
    }
    return loginMsgs.Login_LoginSuccess;
  }
  
  Future<loginMsgs> signUp(String name, String mobile, String pwd) async {
    // Build LC user
    LCUser newUser = new LCUser();
    newUser.username = name;
    newUser.password = pwd;
    newUser.mobile = mobile;

    // Sign Up
    try {
      LCUser result = await newUser.signUp();
    } on LCException catch (e) {
      switch (e.code) {
        case 202: {
          return loginMsgs.SignUp_UsernameUsed;
        }
        case 214: {
          return loginMsgs.SignUp_MobileUsed;
        }
      }
    }
    return loginMsgs.SignUp_SignUpSuccess;
  }


}