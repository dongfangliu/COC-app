// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roleCard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

roleCard _$roleCardFromJson(Map<String, dynamic> json) {
  return roleCard()
    ..hp = json['hp'] as int
    ..mp = json['mp'] as int
    ..san = json['san'] as int
    ..luck = json['luck'] as int
    ..strength = json['strength'] as int
    ..constitution = json['constitution'] as int
    ..size = json['size'] as int
    ..appearance = json['appearance'] as int
    ..intelligence = json['intelligence'] as int
    ..willpower = json['willpower'] as int
    ..education = json['education'] as int
    ..agility = json['agility'] as int
    ..alive = json['alive'] as bool
    ..name = json['name'] as String
    ..hometown = json['hometown'] as String
    ..age = json['age'] as int
    ..gender = json['gender'] as int
    ..occupation = json['occupation'] as String
    ..residence = json['residence'] as String
    ..era = json['era'] as String
    ..description = json['description'] as String
    ..backpack = (json['backpack'] as List)
        ?.map((e) =>
            e == null ? null : packable.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..skills = (json['skills'] as List)
        ?.map(
            (e) => e == null ? null : skill.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..additionInfo = json['additionInfo'] as String
    ..isNPC = json['isNPC'] as bool;
}

Map<String, dynamic> _$roleCardToJson(roleCard instance) => <String, dynamic>{
      'hp': instance.hp,
      'mp': instance.mp,
      'san': instance.san,
      'luck': instance.luck,
      'strength': instance.strength,
      'constitution': instance.constitution,
      'size': instance.size,
      'appearance': instance.appearance,
      'intelligence': instance.intelligence,
      'willpower': instance.willpower,
      'education': instance.education,
      'agility': instance.agility,
      'alive': instance.alive,
      'name': instance.name,
      'hometown': instance.hometown,
      'age': instance.age,
      'gender': instance.gender,
      'occupation': instance.occupation,
      'residence': instance.residence,
      'era': instance.era,
      'description': instance.description,
      'backpack': instance.backpack,
      'skills': instance.skills,
      'additionInfo': instance.additionInfo,
      'isNPC': instance.isNPC
    };
