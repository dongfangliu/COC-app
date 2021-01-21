// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coc_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

COC_File _$COC_FileFromJson(Map<String, dynamic> json) {
  return COC_File()
    ..type = json['__type'] as String
    ..cdn = json['cdn'] as String
    ..url = json['url'] as String
    ..filename = json['filename'] as String
    ..file_source =
        _$enumDecodeNullable(_$FILE_SOURCEEnumMap, json['file_source']);
}

Map<String, dynamic> _$COC_FileToJson(COC_File instance) => <String, dynamic>{
      '__type': instance.type,
      'cdn': instance.cdn,
      'url': instance.url,
      'filename': instance.filename,
      'file_source': _$FILE_SOURCEEnumMap[instance.file_source],
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

const _$FILE_SOURCEEnumMap = {
  FILE_SOURCE.ASSET: 'ASSET',
  FILE_SOURCE.STORAGE: 'STORAGE',
  FILE_SOURCE.NETWORK: 'NETWORK',
  FILE_SOURCE.INVALID: 'INVALID',
};
