// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occupations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Occu _$OccuFromJson(Map<String, dynamic> json) {
  return Occu(
    index: json['index'] as int,
    name: json['name'] as String,
    crLow: json['crLow'] as int,
    crHigh: json['crHigh'] as int,
    attr: (json['attr'] as List)?.map((e) => e as String)?.toList(),
    occuSkills: (json['occuSkills'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(int.parse(k), e as int),
            ))
        ?.toList(),
    specialityNum: json['specialityNum'] as int,
    intro: json['intro'] as String,
    attrIntro: json['attrIntro'] as String,
    skillIntro: json['skillIntro'] as String,
  );
}

Map<String, dynamic> _$OccuToJson(Occu instance) => <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'crLow': instance.crLow,
      'crHigh': instance.crHigh,
      'attr': instance.attr,
      'occuSkills': instance.occuSkills
          ?.map((e) => e?.map((k, e) => MapEntry(k.toString(), e)))
          ?.toList(),
      'specialityNum': instance.specialityNum,
      'intro': instance.intro,
      'attrIntro': instance.attrIntro,
      'skillIntro': instance.skillIntro,
    };

OccuListManager _$OccuListManagerFromJson(Map<String, dynamic> json) {
  return OccuListManager()
    ..occusPath = json['occusPath'] as String
    ..occuList = (json['occuList'] as List)
        ?.map(
            (e) => e == null ? null : Occu.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OccuListManagerToJson(OccuListManager instance) =>
    <String, dynamic>{
      'occusPath': instance.occusPath,
      'occuList': instance.occuList,
    };
