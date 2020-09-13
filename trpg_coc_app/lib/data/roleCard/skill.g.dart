// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

skill _$skillFromJson(Map<String, dynamic> json) {
  return skill()
    ..name = json['name'] as String
    ..baseValue = json['baseValue'] as int
    ..intrestPoint = json['intrestPoint'] as int
    ..occupationPoint = json['occupationPoint'] as int;
}

Map<String, dynamic> _$skillToJson(skill instance) => <String, dynamic>{
      'name': instance.name,
      'baseValue': instance.baseValue,
      'intrestPoint': instance.intrestPoint,
      'occupationPoint': instance.occupationPoint,
    };
