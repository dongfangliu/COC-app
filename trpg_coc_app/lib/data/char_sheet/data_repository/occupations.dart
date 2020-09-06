import 'dart:convert' show json;
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/skills.dart';

part 'occupations.g.dart';

/* TODO Occus 考虑做成单例，将数据放进 json 读取
    职业表与技能表高度耦合，需要重新设计或者在编写 json 时不能出错 */

@JsonSerializable(nullable: true)
class Occu {
  // region 职业信息
  int index;    // 职业序号
  String name;  // 职业名称
  int crLow;    // 信用评级（不低于）
  int crHigh;   // 信用评级（不高于）

  /*
   *  技能点数的计算方法（职业属性）：
   *  若 attr == null，技能点数为 教育 * 4
   *  若 attr != null，技能点数为 教育 * 2 + Max(attr) * 2
   */
  List<String> attr;
  // 存放需要选择的技能组的所有编号（将不需要选择的技能看作只有一个技能的技能组）
  List<Map<int, int>> occuSkills;
  // 针对个别（如生存）技能的备注，int 为技能编号
  // 个人或时代特长数量
  int specialityNum;

  String intro;       // 职业介绍
  String attrIntro;   // 技能点数计算介绍
  String skillIntro;  // 职业技能介绍
  // endregion
/*
  Occu({
    @required this.index,
    @required this.name,
    @required this.crLow,
    @required this.crHigh,

    @required this.attr,
    @required this.occuSkills,
    @required this.specialityNum,

    @required this.intro,
    @required this.attrIntro,
    @required this.skillIntro,
  });*/

  Occu({
    this.index,
    this.name,
    this.crLow,
    this.crHigh,

    this.attr,
    this.occuSkills,
    this.specialityNum,

    this.intro,
    this.attrIntro,
    this.skillIntro,
  });

  factory Occu.fromJson(Map<String, dynamic> json) => _$OccuFromJson(json);

  Map<String, dynamic> toJson() => _$OccuToJson(this);
}

@JsonSerializable()
class OccuListManager {
  String occusPath = 'assets/occupations.json';

  List<Occu> occuList = [];

  OccuListManager();

  Future<List<Occu>> readOccuList() async {
    try {
      // Read occupation json file
      String occuFile = await rootBundle.loadString(occusPath);
      // Decode all the occupations
      List<dynamic> occusJson = json.decode(occuFile);
      // Decode each occupation
      for (int i = 0; i < occusJson.length; i++){
        Occu occu = Occu.fromJson(occusJson[i]);
        occuList.add(occu);
      }
    } catch (e) { print(e); }
    return occuList;
  }

  factory OccuListManager.fromJson(Map<String, dynamic> json) => _$OccuListManagerFromJson(json);

  Map<String, dynamic> toJson() => _$OccuListManagerToJson(this);
}