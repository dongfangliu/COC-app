
import 'dart:convert';

import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import '../storyModule/storyModOnUse.dart';
import 'package:json_annotation/json_annotation.dart';
import 'gameGroupUserData.dart';

part 'gameGroup.g.dart';

enum gameGroupStatus{
@JsonValue(0)
  HIRING,
@JsonValue(1)
HIRED_FULL,
@JsonValue(2)
ONGOING,
@JsonValue(3)
ARCHIVED//0=招募中，1=已招满，2=进行中，3=已结束
}

//class gameParamSetting{
//
//}

@JsonSerializable()
class gameGroup extends BmobObject{
  String name="";
  gameGroupStatus status;
  int roomID=-1;
//  storyModule module=storyModule();
  String description="";
  String note="";//其他一些备注信息
  List<gameGroupUserData> participants=[];//0 is KP/GM
//  gameParamSetting setting=gameParamSetting();
  int lastActiveTime=0;
  int estimatedDayLength = 10;
  int startTime=0;
  int minSize=0,maxSize=10;
  factory gameGroup.fromJson(Map<String, dynamic> json) => _$gameGroupFromJson(json);
  Map<String, dynamic> toJson() => _$gameGroupToJson(this);
  @override
  Map getParams() {
    return toJson();
  }

  gameGroup();

}