// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

packable _$packableFromJson(Map<String, dynamic> json) {
  return packable()
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..num = json['num'] as int
    ..loc = json['loc'] as String;
}

Map<String, dynamic> _$packableToJson(packable instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'num': instance.num,
      'loc': instance.loc,
    };
