// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attr_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttrData _$AttrDataFromJson(Map<String, dynamic> json) {
  return AttrData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..str = json['str'] as num
    ..con = json['con'] as num
    ..siz = json['siz'] as num
    ..dex = json['dex'] as num
    ..app = json['app'] as num
    ..int = json['int'] as num
    ..pow = json['pow'] as num
    ..edu = json['edu'] as num
    ..luc = json['luc'] as num;
}

Map<String, dynamic> _$AttrDataToJson(AttrData instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'str': instance.str,
      'con': instance.con,
      'siz': instance.siz,
      'dex': instance.dex,
      'app': instance.app,
      'int': instance.int,
      'pow': instance.pow,
      'edu': instance.edu,
      'luc': instance.luc,
    };
