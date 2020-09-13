// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'char_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharDataTemplate<T> _$CharDataTemplateFromJson<T extends COCFile>(
    Map<String, dynamic> json) {
  return CharDataTemplate<T>()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..avatar = _dataFromJson(json['avatar'] as Map<String, dynamic>)
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

Map<String, dynamic> _$CharDataTemplateToJson<T extends COCFile>(
        CharDataTemplate<T> instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'avatar': _dataToJson(instance.avatar),
      'infoData': instance.infoData,
      'attrData': instance.attrData,
      'occuData': instance.occuData,
      'skillData': instance.skillData,
      'combatData': instance.combatData,
      'invtData': instance.invtData,
      'storyData': instance.storyData,
    };

CharData _$CharDataFromJson(Map<String, dynamic> json) {
  return CharData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..avatar = _dataFromJson(json['avatar'] as Map<String, dynamic>)
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
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'avatar': _dataToJson(instance.avatar),
      'infoData': instance.infoData,
      'attrData': instance.attrData,
      'occuData': instance.occuData,
      'skillData': instance.skillData,
      'combatData': instance.combatData,
      'invtData': instance.invtData,
      'storyData': instance.storyData,
    };
