import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:trpgcocapp/data/char_sheet/info_data.dart';
import 'package:trpgcocapp/data/char_sheet/attr_data.dart';
import 'package:trpgcocapp/data/char_sheet/occu_data.dart';
import 'package:trpgcocapp/data/char_sheet/skill_data.dart';
import 'package:trpgcocapp/data/char_sheet/combat_data.dart';
import 'package:trpgcocapp/data/char_sheet/invt_data.dart';
import 'package:trpgcocapp/data/char_sheet/story_data.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:trpgcocapp/data/file/coc_file.dart';

part 'char_data.g.dart';

@JsonSerializable()
class CharDataTemplate extends BmobObject{
  COC_File avatar;
  InfoData infoData;
  AttrData attrData;
  OccuData occuData;
  SkillData skillData;
  CombatData combatData;
  InvtData invtData;
  StoryData storyData;

  CharDataTemplate();

  factory CharDataTemplate.fromJson(Map<String, dynamic> json) => _$CharDataTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$CharDataTemplateToJson(this);

  @override
  Map getParams() {
    return toJson();
  }
}
@JsonSerializable()
class CharData extends CharDataTemplate {
  factory CharData.fromJson(Map<String, dynamic> json) => _$CharDataFromJson(json);

  CharData();
  Map<String, dynamic> toJson() => _$CharDataToJson(this);
}


//class CharDataCreate extends CharDataTemplate{
//
//  CharDataCreate(){avatar =COC_File.Asset(url:"assets/images/user_avatar.png"); }
//
//}
//T _dataFromJson<T>(Map<String, dynamic> input) => input['value'] as T;
//
//Map<String, dynamic> _dataToJson<T>(T input) => {'value': input};
