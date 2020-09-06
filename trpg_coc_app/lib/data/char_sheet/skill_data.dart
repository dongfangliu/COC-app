//part of 'char_data_part.dart';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

import 'char_data_part.dart';
import 'attr_data.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/skills.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/occupations.dart';

import 'occu_data.dart';

part 'skill_data.g.dart';

@JsonSerializable(nullable: true)
class SkillData extends CharDataPart {
  SkillManager skillManager;  // 技能表
  int occuSkillPoints = 0;      // 职业技能点数
  int interestSkillPoints = 0;  // 兴趣技能点数
  /*
   * 记录技能的选项 Quick Fill Choices
   *  固定技能：值为 0
   *  可选技能：在玩家未选择时值为 -1
   * 由 Occu.occuSkills 决定数组长度
   */
  List<int> qfChoices;
  /*
   * 所有可选以及不可选的职业技能 Quick Fill Occupation Skills
   * qfOccuSkills 中的所有项全部通过引用传递来自与 skillManager.skillList
   */
  List<List<SingleSkill>> qfOccuSkills;

  //SkillData();

  SkillData({Occu occu, AttrData attrData}) {
    if (occu != null) {
      skillManager = SkillManager();
      qfChoices = [];
      qfOccuSkills = [];

      // region 1. 初始化 qfChoices 和 qfOccuSkills（翻译 occuSkills）
      List<Map<int, int>> occuSkills = occu.occuSkills;

      // 首先加入信用评级
      // TODO 其次需要加入母语
      qfChoices.add(0);
      qfOccuSkills.add([skillManager.skillList[8]]);

      for (int i = 0; i < occuSkills.length; i++) {
        Map<int, int> current = occuSkills[i]; // 当前处理的技能组

        int newChoice;
        List<SingleSkill> newSkills = [];

        if (current.length == 1){
          current.forEach((key, val){ // 明知 length 是 1 还要遍历…
            if(skillManager.skillList[key] is SingleSkill) {
              // 纯 SingleSkill
              SingleSkill currentSS = skillManager.skillList[key];
              newChoice = 0;
              newSkills.add(currentSS);
            } else {
              GroupSkill currentGS = skillManager.skillList[key];
              if (val == -1) {
                // 纯 GroupSkill，可选范围为所有子技能
                newChoice = -1;
                newSkills.addAll(currentGS.childSkills);
              } else {
                // 单个 GroupSkill 的子技能
                newChoice = 0;
                newSkills.add(currentGS.childSkills[val]);
              }
            }
          });
        } else {
          newChoice = -1;
          // 技能数量大于一，必定会有选择项，接下来考虑往 qfOccuSkills 中加多少东西
          current.forEach((key, val){
            if(skillManager.skillList[key] is SingleSkill) {
              // 纯 SingleSkill
              SingleSkill currentSS = skillManager.skillList[key];
              newSkills.add(currentSS);
            } else {
              GroupSkill currentGS = skillManager.skillList[key];
              if (val == -1) { newSkills.addAll(currentGS.childSkills);}
              else { newSkills.add(currentGS.childSkills[val]); }
            }
          });
        }

        qfChoices.add(newChoice);
        qfOccuSkills.add(newSkills);
      }
      // endregion
      // region 2. updateSkillPoints(occu, attrData);
      updateSkillPoints(occu, attrData);
      // endregion
    }
  }

  void updateSkillPoints(Occu occu, AttrData attrData){
    // 1. 设置职业技能点数
    if (occu.attr.length == 0) {
      occuSkillPoints = attrData.edu * 4;
    } else {
      List<int> attrVals = [];
      for (int i = 0; i < occu.attr.length; i++) {
        switch (occu.attr[i]) {
          case "str": attrVals.add(attrData.str); break;
          case "con": attrVals.add(attrData.con); break;
          case "siz": attrVals.add(attrData.siz); break;
          case "dex": attrVals.add(attrData.dex); break;
          case "app": attrVals.add(attrData.app); break;
          case "int": attrVals.add(attrData.int); break;
          case "pow": attrVals.add(attrData.pow); break;
        }
      }
      occuSkillPoints = attrData.edu * 2 + attrVals.reduce(max) * 2;
    }

    // 2. 设置兴趣技能点数
    interestSkillPoints = attrData.int * 2;
  }

  bool isFinished() {
    if (skillManager == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Map getParams() {
    // TODO: implement getParams
    throw UnimplementedError();
  }

  factory SkillData.fromJson(Map<String, dynamic> json) => _$SkillDataFromJson(json);

  Map<String, dynamic> toJson() => _$SkillDataToJson(this);
}

/*
class SkillChoice {
  /*
   * 将技能表看作二维数组以准确定位一个 SingleSkill
   *  1. main 表示 row （SkillManager.skillList 中的位置）
   *  2. secondary 表示 col （GroupSkill 的哪个子技能）
   */

  int main;
  int secondary;
}
*/
