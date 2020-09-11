import 'dart:async';
import 'dart:io';

import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operator.dart';
import 'package:trpgcocapp/data/file/coc_file.dart';
import 'package:trpgcocapp/data/roleCard/roleCard.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';

class ModuleCreationRepository {
  static StoryModCreate modCreate;
  static Future<OperateResult> init()async {
    String appId = 'c0e5dbfe38a164ba90d2c4c7e1c846a9';
    String apiKey = '6fc3e0520028a3a095ebb8aa1097c10e';
    String appHost = 'https://api2.bmob.cn';
    Bmob.init(appHost, appId, apiKey);
    if (modCreate == null) {
      modCreate = StoryModCreate(
          new List<roleCard>(),
          "undefined",
          0,
          0,
          0,
          0,
          0);
    }
    OperateResult result = OperateResult();
    result.isSuccess = true;
    return result;
  }
  static StoryModCreate getInstance(){
    if (modCreate == null) {
      modCreate = StoryModCreate(
          new List<roleCard>(),
          "undefined",
          0,
          0,
          0,
          0,
          0);
      return modCreate;;
    }
  }
  static Future<OperateResult> submmit() async {
    try {
      StoryModUsing modUsing =
          await ModuleCreationHelper.convertToUsing(modCreate);
      // others
      BmobSaved bmobSaved = await modUsing.save();
      OperateResult result = OperateResult();
      result.isSuccess = true;
      result.result = null;
      result.msg = bmobSaved.toString();
      return result;
    } catch (e) {
      OperateResult result = OperateResult();
      result.isSuccess = false;
      result.msg = e.toString();
      return result;
    }
  }
}

class ModuleCreationHelper {
  static Future<File> pickImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    return imageFile;
  }

  static Future<roleCard> addNPC() {}
  static Future<StoryModUsing> convertToUsing(StoryModCreate _modCreate) async {
    try {
      StoryModUsing modUsing = new StoryModUsing(
          _modCreate.npcs,
          _modCreate.moduleName,
          _modCreate.hours_min,
          _modCreate.hours_max,
          _modCreate.people_min,
          _modCreate.people_max,
          0);
      await modUsing.from(_modCreate);
      return modUsing;
    } catch (e) {
      throw e;
    }
  }
}
