// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return Skill()
    ..index = json['index'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
    };

SingleSkill _$SingleSkillFromJson(Map<String, dynamic> json) {
  return SingleSkill(
    index: json['index'] as int,
    name: json['name'] as String,
    initialVal: json['initialVal'] as int,
    groupIndex: json['groupIndex'] as int,
  )
    ..occuVal = json['occuVal'] as int
    ..interestVal = json['interestVal'] as int;
}

Map<String, dynamic> _$SingleSkillToJson(SingleSkill instance) =>
    <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'initialVal': instance.initialVal,
      'occuVal': instance.occuVal,
      'interestVal': instance.interestVal,
      'groupIndex': instance.groupIndex,
    };

GroupSkill _$GroupSkillFromJson(Map<String, dynamic> json) {
  return GroupSkill(
    index: json['index'] as int,
    name: json['name'] as String,
    childSkills: (json['childSkills'] as List)
        ?.map((e) =>
            e == null ? null : SingleSkill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GroupSkillToJson(GroupSkill instance) =>
    <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'childSkills': instance.childSkills,
    };

SkillManager _$SkillManagerFromJson(Map<String, dynamic> json) {
  return SkillManager()
    ..skillList = (json['skillList'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SkillManagerToJson(SkillManager instance) =>
    <String, dynamic>{
      'skillList': instance.skillList,
    };
