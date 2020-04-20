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
    //tryResigter();
    bool result = await FlutterQq.isQQInstalled();
    return result;
  }

  static Future<Map> handleQQLogin() async {
    try {
      //tryResigter();
      var qqResult = await FlutterQq.login();
      if(qqResult.code == 0){
        print(qqResult.response);
        return qqResult.response;
      }else{
        print(qqResult);
        return null;
      }
    } catch (error) {
      print("flutter_plugin_qq_example:" + error.toString());
      return null;
    }
  }
}