import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/skills.dart';

import 'package:json_annotation/json_annotation.dart';

part 'weapons.g.dart';

@JsonSerializable()
class Weapon {
  // int index;
  String name;      // 武器类型名
  int useSkillRow;  // 使用技能（Row 和 Col 定位一个 SingleSkill）
  int useSkillCol;  // 使用技能
  String damage;    // 伤害
  String range;     // 射程
  bool penetrable;  // 是否贯穿
  int perRound;     // 每轮
  int load;         // 装弹量
  int failure;      // 故障值
  String era;       // 常见时代
  int price20s;    // 1920 年代价格($)
  int priceModern; // 现代价格($)
  // String inventEra; // 发明时间

  Weapon({
    // @required this.index,
    @required this.name,
    @required this.useSkillRow,
    @required this.useSkillCol,
    @required this.damage,
    @required this.range,
    @required this.penetrable,
    @required this.perRound,
    @required this.load,
    @required this.failure,
    @required this.era,
    @required this.price20s,
    @required this.priceModern
    // this.inventEra
  });

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponToJson(this);
}

@JsonSerializable()
class WeaponListManager {
  String weaponsPath = 'assets/weapons.json';

  List<Weapon> weaponList = [];

  WeaponListManager();

  Future<List<Weapon>> readWeaponList() async {
    try {
      // Read weapon json file
      String weaponFile = await rootBundle.loadString(weaponsPath);
      // Decode all the weapons
      List<dynamic> weaponsJson = json.decode(weaponFile);
      // Decode each weapon
      for (int i = 0; i < weaponsJson.length; i++){
        Weapon weapon = Weapon.fromJson(weaponsJson[i]);
        weaponList.add(weapon);
      }
    } catch (e) { print(e); }
    return weaponList;
  }

  factory WeaponListManager.fromJson(Map<String, dynamic> json) => _$WeaponListManagerFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponListManagerToJson(this);
}