// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occu_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccuData _$OccuDataFromJson(Map<String, dynamic> json) {
  return OccuData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..occu = json['occu'] == null
        ? null
        : Occu.fromJson(json['occu'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OccuDataToJson(OccuData instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'occu': instance.occu,
    };
