import 'dart:async';
import 'dart:io';

import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operator.dart';
import 'package:trpgcocapp/data/coc_file.dart';
import 'package:trpgcocapp/data/roleCard/roleCard.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';

class ModuleCreationRepository{
  static StoryModCreate modCreate;
  static File ModThumbnail;
  static File defaultSubSceneBg;
  static File defaultMapBg;
  static Future<OperateResult> initDefaultFiles() async{
    try{
      if(ModThumbnail ==null) {
        ModThumbnail = await FileGenerator.fromAsset('images/add.png');
      }
      if(defaultSubSceneBg==null){
      defaultSubSceneBg = await FileGenerator.fromAsset('images/subscenebg.jpg');
      }
      if(defaultMapBg==null){
        defaultMapBg = await FileGenerator.fromAsset('images/map.png');
      }
      OperateResult result=OperateResult.custom("success initilized", true, null);
      return result;
    }catch(e){
      OperateResult result=OperateResult();result.isSuccess=false;result.msg=e.toString();
      return result;
    }
  }
  static Future<OperateResult> submmit() async{
    try {
      StoryModUsing modUsing = await ModuleCreationHelper.convertToUsing(
          modCreate);
      // others
      BmobSaved bmobSaved = await modUsing.save();
      OperateResult result=OperateResult();result.isSuccess=true;
      result.result=null;result.msg=bmobSaved.toString();
      return result;
    }catch(e){
      OperateResult result=OperateResult();result.isSuccess=false;result.msg=e.toString();
      return result;
    }
  }


}
class ModuleCreationHelper{
  static Future<File> pickImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    return imageFile;
  }
  static Future<roleCard> addNPC(){

  }
  static Future<StoryModUsing> convertToUsing(StoryModCreate _modCreate) async {
    try {
      StoryModUsing modUsing = await StoryModUsing.from(_modCreate);
      return modUsing;
    } catch (e) {
      throw e;
    }
  }
}
