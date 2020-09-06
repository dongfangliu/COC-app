// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weapons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weapon _$WeaponFromJson(Map<String, dynamic> json) {
  return Weapon(
    name: json['name'] as String,
    useSkillRow: json['useSkillRow'] as int,
    useSkillCol: json['useSkillCol'] as int,
    damage: json['damage'] as String,
    range: json['range'] as String,
    penetrable: json['penetrable'] as bool,
    perRound: json['perRound'] as int,
    load: json['load'] as int,
    failure: json['failure'] as int,
    era: json['era'] as String,
    price20s: json['price20s'] as int,
    priceModern: json['priceModern'] as int,
  );
}

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'name': instance.name,
      'useSkillRow': instance.useSkillRow,
      'useSkillCol': instance.useSkillCol,
      'damage': instance.damage,
      'range': instance.range,
      'penetrable': instance.penetrable,
      'perRound': instance.perRound,
      'load': instance.load,
      'failure': instance.failure,
      'era': instance.era,
      'price20s': instance.price20s,
      'priceModern': instance.priceModern,
    };

WeaponListManager _$WeaponListManagerFromJson(Map<String, dynamic> json) {
  return WeaponListManager()
    ..weaponsPath = json['weaponsPath'] as String
    ..weaponList = (json['weaponList'] as List)
        ?.map((e) =>
            e == null ? null : Weapon.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$WeaponListManagerToJson(WeaponListManager instance) =>
    <String, dynamic>{
      'weaponsPath': instance.weaponsPath,
      'weaponList': instance.weaponList,
    };
