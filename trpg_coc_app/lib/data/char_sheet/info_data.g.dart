// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoData _$InfoDataFromJson(Map<String, dynamic> json) {
  return InfoData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..avatar = json['avatar'] == null
        ? null
        : COC_File.fromJson(json['avatar'] as Map<String, dynamic>)
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..name = json['name'] as String
    ..era = json['era'] as String
    ..age = json['age'] as int
    ..sex = json['sex'] as String
    ..residence = json['residence'] as String
    ..birthplace = json['birthplace'] as String;
}

Map<String, dynamic> _$InfoDataToJson(InfoData instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
  'avatar': instance.avatar,
      'name': instance.name,
      'era': instance.era,
      'age': instance.age,
      'sex': instance.sex,
      'residence': instance.residence,
      'birthplace': instance.birthplace,
    };
