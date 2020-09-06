// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillData _$SkillDataFromJson(Map<String, dynamic> json) {
  return SkillData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..skillManager = json['skillManager'] == null
        ? null
        : SkillManager.fromJson(json['skillManager'] as Map<String, dynamic>)
    ..occuSkillPoints = json['occuSkillPoints'] as int
    ..interestSkillPoints = json['interestSkillPoints'] as int
    ..qfChoices = (json['qfChoices'] as List)?.map((e) => e as int)?.toList()
    ..qfOccuSkills = (json['qfOccuSkills'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : SingleSkill.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList();
}

Map<String, dynamic> _$SkillDataToJson(SkillData instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'skillManager': instance.skillManager,
      'occuSkillPoints': instance.occuSkillPoints,
      'interestSkillPoints': instance.interestSkillPoints,
      'qfChoices': instance.qfChoices,
      'qfOccuSkills': instance.qfOccuSkills,
    };
