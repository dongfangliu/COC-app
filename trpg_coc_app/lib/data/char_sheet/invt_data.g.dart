// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invt_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvtData _$InvtDataFromJson(Map<String, dynamic> json) {
  return InvtData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..cash = (json['cash'] as num)?.toDouble();
}

Map<String, dynamic> _$InvtDataToJson(InvtData instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'cash': instance.cash,
    };
