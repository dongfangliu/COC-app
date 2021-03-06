// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storyMod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryMap _$StoryMapFromJson(Map<String, dynamic> json) {
  return StoryMap()
    ..mapImg = json['mapImg'] == null
        ? null
        : COC_File.fromJson(json['mapImg'] as Map<String, dynamic>)
    ..scenes = (json['scenes'] as List)
        ?.map((e) =>
            e == null ? null : StoryScene.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$StoryMapToJson(StoryMap instance) => <String, dynamic>{
      'mapImg': instance.mapImg,
      'scenes': instance.scenes,
    };

StoryScene _$StorySceneFromJson(Map<String, dynamic> json) {
  return StoryScene(
    json['name'] as String,
    json['mainSceneIdx'] as int,
    (json['npcsId'] as List)?.map((e) => e as int)?.toList(),
    (json['xPosition'] as num)?.toDouble(),
    (json['yPosition'] as num)?.toDouble(),
  )..subScenes = (json['subScenes'] as List)
      ?.map((e) =>
          e == null ? null : StorySubScene.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$StorySceneToJson(StoryScene instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mainSceneIdx': instance.mainSceneIdx,
      'xPosition': instance.xPosition,
      'yPosition': instance.yPosition,
      'subScenes': instance.subScenes,
      'npcsId': instance.npcsId,
    };

StorySubScene _$StorySubSceneFromJson(Map<String, dynamic> json) {
  return StorySubScene(
    json['name'] as String,
  )..bgImg = json['bgImg'] == null
      ? null
      : COC_File.fromJson(json['bgImg'] as Map<String, dynamic>);
}

Map<String, dynamic> _$StorySubSceneToJson(StorySubScene instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bgImg': instance.bgImg,
    };

StoryMod _$StoryModFromJson(Map<String, dynamic> json) {
  return StoryMod(
    (json['npcs'] as List)
        ?.map((e) => e == null
            ? null
            : CharDataTemplate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['moduleName'] as String,
    json['hours_min'] as int,
    json['hours_max'] as int,
    json['people_min'] as int,
    json['people_max'] as int,
    json['likes'] as int,
  )
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
        : COC_File.fromJson(json['thumbnailImg'] as Map<String, dynamic>)
    ..iconImg = json['iconImg'] == null
        ? null
        : COC_File.fromJson(json['iconImg'] as Map<String, dynamic>)
    ..author = json['author'] as String
    ..era = _$enumDecodeNullable(_$ModEraEnumMap, json['era'])
    ..region = _$enumDecodeNullable(_$ModRegionEnumMap, json['region'])
    ..tags = (json['tags'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$StoryModToJson(StoryMod instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'map': instance.map,
      'npcs': instance.npcs,
      'moduleName': instance.moduleName,
      'descript': instance.descript,
      'thumbnailImg': instance.thumbnailImg,
      'iconImg': instance.iconImg,
      'hours_min': instance.hours_min,
      'hours_max': instance.hours_max,
      'people_min': instance.people_min,
      'people_max': instance.people_max,
      'author': instance.author,
      'likes': instance.likes,
      'era': _$ModEraEnumMap[instance.era],
      'region': _$ModRegionEnumMap[instance.region],
      'tags': instance.tags,
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

const _$ModEraEnumMap = {
  ModEra.NINETEENTH: '1920s',
  ModEra.MODERN: 'modern',
  ModEra.OTHERS: 'others',
  ModEra.PPRESENT: 'present',
};

const _$ModRegionEnumMap = {
  ModRegion.America: 'America',
  ModRegion.Europe: 'Europe',
  ModRegion.China: 'China',
  ModRegion.Japan: 'Japan',
  ModRegion.others: 'others',
};
