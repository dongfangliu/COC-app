// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storyModOnUse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryMapUsing _$StoryMapUsingFromJson(Map<String, dynamic> json) {
  return StoryMapUsing()
    ..mapImg = json['mapImg'] == null
        ? null
        : _dataFromJson(json['mapImg'] as Map<String, dynamic>)
    ..scenes = (json['scenes'] as List)
        ?.map((e) =>
            e == null ? null : StoryScene.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$StoryMapUsingToJson(StoryMapUsing instance) =>
    <String, dynamic>{
      'mapImg': instance.mapImg == null ? null : _dataToJson(instance.mapImg),
      'scenes': instance.scenes
    };

StorySceneUsing _$StorySceneUsingFromJson(Map<String, dynamic> json) {
  return StorySceneUsing(
      json['name'] as String,
      json['mainSceneIdx'] as int,
      (json['npcsId'] as List)?.map((e) => e as int)?.toList(),
      (json['xPosition'] as num)?.toDouble(),
      (json['yPosition'] as num)?.toDouble())
    ..subScenes = (json['subScenes'] as List)
        ?.map((e) => e == null
            ? null
            : StorySubScene.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$StorySceneUsingToJson(StorySceneUsing instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mainSceneIdx': instance.mainSceneIdx,
      'xPosition': instance.xPosition,
      'yPosition': instance.yPosition,
      'subScenes': instance.subScenes,
      'npcsId': instance.npcsId
    };

StorySubSceneUsing _$StorySubSceneUsingFromJson(Map<String, dynamic> json) {
  return StorySubSceneUsing(json['name'] as String)
    ..bgImg = json['bgImg'] == null
        ? null
        : _dataFromJson(json['bgImg'] as Map<String, dynamic>);
}

Map<String, dynamic> _$StorySubSceneUsingToJson(StorySubSceneUsing instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bgImg': instance.bgImg == null ? null : _dataToJson(instance.bgImg)
    };

StoryModUsing _$StoryModUsingFromJson(Map<String, dynamic> json) {
  return StoryModUsing(
      (json['npcs'] as List)
          ?.map((e) =>
              e == null ? null : roleCard.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['moduleName'] as String,
      json['hours_min'] as int,
      json['hours_max'] as int,
      json['people_min'] as int,
      json['people_max'] as int,
      json['likes'] as int)
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..map = json['map'] == null
        ? null
        : StoryMap.fromJson(json['map'] as Map<String, dynamic>)
    ..descript = json['descript'] as String
    ..thumbnailImg = json['thumbnailImg'] == null
        ? null
        : _dataFromJson(json['thumbnailImg'] as Map<String, dynamic>)
    ..author = json['author'] as String
    ..era = _$enumDecodeNullable(_$ModEraEnumMap, json['era'])
    ..region = _$enumDecodeNullable(_$ModRegionEnumMap, json['region'])
    ..tags = (json['tags'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$StoryModUsingToJson(StoryModUsing instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'map': instance.map,
      'npcs': instance.npcs,
      'moduleName': instance.moduleName,
      'descript': instance.descript,
      'thumbnailImg': instance.thumbnailImg == null
          ? null
          : _dataToJson(instance.thumbnailImg),
      'hours_min': instance.hours_min,
      'hours_max': instance.hours_max,
      'people_min': instance.people_min,
      'people_max': instance.people_max,
      'author': instance.author,
      'likes': instance.likes,
      'era': _$ModEraEnumMap[instance.era],
      'region': _$ModRegionEnumMap[instance.region],
      'tags': instance.tags
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

const _$ModEraEnumMap = <ModEra, dynamic>{
  ModEra.NINETEENTH: '1920s',
  ModEra.MODERN: 'modern',
  ModEra.OTHERS: 'others',
  ModEra.PPRESENT: 'present'
};

const _$ModRegionEnumMap = <ModRegion, dynamic>{
  ModRegion.America: 'America',
  ModRegion.Europe: 'Europe',
  ModRegion.China: 'China',
  ModRegion.Japan: 'Japan',
  ModRegion.others: 'others'
};