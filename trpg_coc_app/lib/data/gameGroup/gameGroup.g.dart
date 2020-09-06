// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gameGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

gameGroup _$gameGroupFromJson(Map<String, dynamic> json) {
  return gameGroup()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..name = json['name'] as String
    ..status = _$enumDecodeNullable(_$gameGroupStatusEnumMap, json['status'])
    ..roomID = json['roomID'] as int
    ..description = json['description'] as String
    ..note = json['note'] as String
    ..participants = (json['participants'] as List)
        ?.map((e) => e == null
            ? null
            : gameGroupUserData.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..lastActiveTime = json['lastActiveTime'] as int
    ..estimatedDayLength = json['estimatedDayLength'] as int
    ..startTime = json['startTime'] as int
    ..minSize = json['minSize'] as int
    ..maxSize = json['maxSize'] as int;
}

Map<String, dynamic> _$gameGroupToJson(gameGroup instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'name': instance.name,
      'status': _$gameGroupStatusEnumMap[instance.status],
      'roomID': instance.roomID,
      'description': instance.description,
      'note': instance.note,
      'participants': instance.participants,
      'lastActiveTime': instance.lastActiveTime,
      'estimatedDayLength': instance.estimatedDayLength,
      'startTime': instance.startTime,
      'minSize': instance.minSize,
      'maxSize': instance.maxSize
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$gameGroupStatusEnumMap = <gameGroupStatus, dynamic>{
  gameGroupStatus.HIRING: 0,
  gameGroupStatus.HIRED_FULL: 1,
  gameGroupStatus.ONGOING: 2,
  gameGroupStatus.ARCHIVED: 3
};
