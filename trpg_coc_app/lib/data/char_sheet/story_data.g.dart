// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryData _$StoryDataFromJson(Map<String, dynamic> json) {
  return StoryData()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..stories = (json['stories'] as List)?.map((e) => e as String)?.toList()
    ..criticalConnection = json['criticalConnection'] as int;
}

Map<String, dynamic> _$StoryDataToJson(StoryData instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'stories': instance.stories,
      'criticalConnection': instance.criticalConnection,
    };
