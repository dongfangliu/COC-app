// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combat_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CombatData _$CombatDataFromJson(Map<String, dynamic> json) {
  return CombatData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..weaponList = (json['weaponList'] as List)
        ?.map((e) =>
            e == null ? null : Weapon.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CombatDataToJson(CombatData instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'weaponList': instance.weaponList,
    };
