import 'package:flutter_qq/flutter_qq.dart';

class QQLogin {
  static String qqAPPID = '1110330239';
  static bool registered = false;

  QQLogin(){}

  static void tryResigter(){
    if(!registered){
      FlutterQq.registerQQ(QQLogin.qqAPPID);registered=true;
    }
  }

  static Future<bool> handleisQQInstalled() async {
    tryResigter();
    bool result = await FlutterQq.isQQInstalled();
    return result;
  }

  static Future<Map> handleQQLogin() async {
    tryResigter();
    try {
      print('QQLoggingIn1');
      var qqResult = await FlutterQq.login();
      print(qqResult.code);
      if(qqResult.code == 0){
        print(qqResult.response);
        return qqResult.response;
      }else{
        print(qqResult.code);
        return null;
      }
    } catch (error) {
      print("flutter_plugin_qq:" + error.toString());
      return null;
    }
  }
}