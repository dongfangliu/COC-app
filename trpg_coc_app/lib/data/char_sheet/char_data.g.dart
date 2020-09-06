// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'char_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharData _$CharDataFromJson(Map<String, dynamic> json) {
  return CharData()
    ..infoData = json['infoData'] == null
        ? null
        : InfoData.fromJson(json['infoData'] as Map<String, dynamic>)
    ..attrData = json['attrData'] == null
        ? null
        : AttrData.fromJson(json['attrData'] as Map<String, dynamic>)
    ..occuData = json['occuData'] == null
        ? null
        : OccuData.fromJson(json['occuData'] as Map<String, dynamic>)
    ..skillData = json['skillData'] == null
        ? null
        : SkillData.fromJson(json['skillData'] as Map<String, dynamic>)
    ..combatData = json['combatData'] == null
        ? null
        : CombatData.fromJson(json['combatData'] as Map<String, dynamic>)
    ..invtData = json['invtData'] == null
        ? null
        : InvtData.fromJson(json['invtData'] as Map<String, dynamic>)
    ..storyData = json['storyData'] == null
        ? null
        : StoryData.fromJson(json['storyData'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CharDataToJson(CharData instance) => <String, dynamic>{
      'infoData': instance.infoData,
      'attrData': instance.attrData,
      'occuData': instance.occuData,
      'skillData': instance.skillData,
      'combatData': instance.combatData,
      'invtData': instance.invtData,
      'storyData': instance.storyData,
    };
