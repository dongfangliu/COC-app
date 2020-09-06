import 'package:trpgcocapp/data/char_sheet/info_data.dart';
import 'package:trpgcocapp/data/char_sheet/attr_data.dart';
import 'package:trpgcocapp/data/char_sheet/occu_data.dart';
import 'package:trpgcocapp/data/char_sheet/skill_data.dart';
import 'package:trpgcocapp/data/char_sheet/combat_data.dart';
import 'package:trpgcocapp/data/char_sheet/invt_data.dart';
import 'package:trpgcocapp/data/char_sheet/story_data.dart';

import 'package:json_annotation/json_annotation.dart';

part 'char_data.g.dart';

@JsonSerializable()
class CharData {
  InfoData infoData;
  AttrData attrData;
  OccuData occuData;
  SkillData skillData;
  CombatData combatData;
  InvtData invtData;
  StoryData storyData;

  CharData();

  factory CharData.fromJson(Map<String, dynamic> json) => _$CharDataFromJson(json);

  Map<String, dynamic> toJson() => _$CharDataToJson(this);
}