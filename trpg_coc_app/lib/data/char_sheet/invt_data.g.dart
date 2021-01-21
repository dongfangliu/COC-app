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
    ..livingStd = json['livingStd'] as String
    ..cash = (json['cash'] as num)?.toDouble()
    ..otherAsset = json['otherAsset'] as int
    ..consumptionStd = (json['consumptionStd'] as num)?.toDouble()
    ..assetDesc = json['assetDesc'] as String
    ..invts = (json['invts'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$InvtDataToJson(InvtData instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'livingStd': instance.livingStd,
      'cash': instance.cash,
      'otherAsset': instance.otherAsset,
      'consumptionStd': instance.consumptionStd,
      'assetDesc': instance.assetDesc,
      'invts': instance.invts,
    };
