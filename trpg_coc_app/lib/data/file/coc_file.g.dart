// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coc_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

COCServerFile<T> _$COCServerFileFromJson<T>(Map<String, dynamic> json) {
  return COCServerFile<T>()
    ..serverfile = _dataFromJson(json['serverfile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$COCServerFileToJson<T>(COCServerFile<T> instance) =>
    <String, dynamic>{
      'serverfile': _dataToJson(instance.serverfile),
    };

COCBmobServerFile _$COCBmobServerFileFromJson(Map<String, dynamic> json) {
  return COCBmobServerFile()
    ..serverfile = _dataFromJson(json['serverfile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$COCBmobServerFileToJson(COCBmobServerFile instance) =>
    <String, dynamic>{
      'serverfile': _dataToJson(instance.serverfile),
    };
