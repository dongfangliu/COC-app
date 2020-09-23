

import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operator.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';

class ModuleUsingHelper {
  static Future<OperateResult> init()async {
    String appId = 'c0e5dbfe38a164ba90d2c4c7e1c846a9';
    String apiKey = '6fc3e0520028a3a095ebb8aa1097c10e';
    String appHost = 'https://api2.bmob.cn';
    Bmob.init(appHost, appId, apiKey);
    OperateResult result = OperateResult();
    result.isSuccess = true;
    return result;
  }

   static Future<OperateResult> addComment(String comment,StoryModUsing mod) async {
  }
   static Future<OperateResult> deleteComment(String comment,StoryModUsing mod) async {
   }
     static Future<OperateResult> addLike() async {
   }
}