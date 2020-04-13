import 'package:flutter_qq/flutter_qq.dart';
class mFlutterQQ {
  mFlutterQQ(){}
  static String qqAPPID = '1110330239';
  static bool registered = false;
  static void tryResigter(){
    if(!registered){
      FlutterQq.registerQQ(mFlutterQQ.qqAPPID);registered=true;
    }
  }

  static Future<bool> handleisQQInstalled() async {
    tryResigter();
    var result = await FlutterQq.isQQInstalled();
    return result!=null;
  }

  static Future<Map> handleQQLogin() async {
    try {
      tryResigter();
      var qqResult = await FlutterQq.login();
      if(qqResult.code==0){
        return qqResult.response;
      }else{
        print(qqResult.message);
        return null;
      }
    } catch (error) {
      print("flutter_plugin_qq_example:" + error.toString());
      return null;
    }
  }
}
