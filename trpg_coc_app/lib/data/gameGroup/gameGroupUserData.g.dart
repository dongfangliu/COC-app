// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameGroupUserData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

gameGroupUserData _$gameGroupUserDataFromJson(Map<String, dynamic> json) {
  return gameGroupUserData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..groupID = json['groupID'] as int
    ..userID = json['userID'] as int
    ..roleID = json['roleID'] as int
    ..identity =
        _$enumDecodeNullable(_$gameGroupIdentityEnumMap, json['identity']);
}

Map<String, dynamic> _$gameGroupUserDataToJson(gameGroupUserData instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'groupID': instance.groupID,
      'userID': instance.userID,
      'roleID': instance.roleID,
      'identity': _$gameGroupIdentityEnumMap[instance.identity],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$gameGroupIdentityEnumMap = {
  gameGroupIdentity.Manager: 0,
  gameGroupIdentity.Player: 1,
};
