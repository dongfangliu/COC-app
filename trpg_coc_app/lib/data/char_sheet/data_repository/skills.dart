import 'package:meta/meta.dart';

import 'package:json_annotation/json_annotation.dart';

part 'skills.g.dart';

@JsonSerializable()
class Skill {
  int index;
  String name;

  Skill();

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);
}

@JsonSerializable()
class SingleSkill extends Skill {
  @override int index;
  @override String name;

  int initialVal;       // 初始技能点
  int occuVal = 0;      // 职业技能点
  int interestVal = 0;  // 兴趣技能点

  int get finalVal => initialVal + occuVal + interestVal;

  int groupIndex;  // 不属于某个组技能则值为 -1

  SingleSkill ({
    @required this.index,
    @required this.name,
    @required this.initialVal,
    this.groupIndex = -1
  });

  factory SingleSkill.fromJson(Map<String, dynamic> json) => _$SingleSkillFromJson(json);

  Map<String, dynamic> toJson() => _$SingleSkillToJson(this);
}

@JsonSerializable()
class GroupSkill extends Skill {
  @override int index;
  @override String name;

  // 所有子技能
  List<SingleSkill> childSkills;
  // 被选中为职业技能的子技能
  List<SingleSkill> get occuSkills {
    List<SingleSkill> occuSkills = [];
    childSkills.forEach((singleSkill){
      if (singleSkill.occuVal > 0) { occuSkills.add(singleSkill); }
    });
    return occuSkills;
  }
  // 被选中为兴趣技能的子技能
  List<SingleSkill> get interestSkills {
    List<SingleSkill> interestSkills = [];
    childSkills.forEach((singleSkill){
      if (singleSkill.interestVal > 0) { interestSkills.add(singleSkill); }
    });
    return interestSkills;
}

  GroupSkill ({
    @required this.index,
    @required this.name,
    @required this.childSkills,
  });

  factory GroupSkill.fromJson(Map<String, dynamic> json) => _$GroupSkillFromJson(json);

  Map<String, dynamic> toJson() => _$GroupSkillToJson(this);
}

@JsonSerializable()
class SkillManager {

  /*
   * SingleSkill 表示不可再分割的技能
   * GroupSkill 表示包含子技能 或者 具有自定义项的技能（22 母语，53 学识）
   * 可选技能若是职业表有指定的需添加在 region Initial Group Skills 中每一项最后
   * 如此才能在职业的 json 中指定出来
   */
  List<Skill> skillList;  // 主要的技能表

  // 记录每个 GroupSkill 在 skillList 中的位置
  static final int acIndex = 4;
  static final int combatIndex = 16;
  static final int shootingIndex = 17;
  static final int flIndex = 23;
  static final int driveIndex = 35;
  static final int scienceIndex = 39;
  static final int surviveIndex = 43;

  // 每个 GroupSkill 的所有初始子技能
  List<SingleSkill> _artAndCraft;
  List<SingleSkill> _combat;
  List<SingleSkill> _shooting;
  List<SingleSkill> _foreignLanguages;
  List<SingleSkill> _drive;
  List<SingleSkill> _science;
  List<SingleSkill> _survive;


  SkillManager(){
    // region Initialize Group Skills
    _artAndCraft = [
      SingleSkill(index: 0, name: "表演", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 1, name: "美术", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 2, name: "摄影", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 3, name: "伪造", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 4, name: "文学", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 5, name: "书法", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 6, name: "乐理", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 7, name: "厨艺", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 8, name: "裁缝", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 9, name: "理发", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 10, name: "建筑", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 11, name: "舞蹈", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 12, name: "酿酒", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 13, name: "捕鱼", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 14, name: "歌唱", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 15, name: "制陶", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 16, name: "雕塑", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 17, name: "杂技", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 18, name: "风水", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 19, name: "技术制图", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 20, name: "耕作", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 21, name: "打字", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 22, name: "速记", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 23, name: "木匠", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 24, name: "莫里斯舞", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 25, name: "歌剧歌唱", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 26, name: "粉刷匠与油漆工", initialVal: 5, groupIndex: acIndex),
      SingleSkill(index: 27, name: "吹制玻璃管", initialVal: 5, groupIndex: acIndex),
    ];
    _combat = [
      SingleSkill(index: 0, name: "鞭子", initialVal: 5, groupIndex: combatIndex),
      SingleSkill(index: 1, name: "电锯", initialVal: 10, groupIndex: combatIndex),
      SingleSkill(index: 2, name: "斗殴", initialVal: 25, groupIndex: combatIndex),
      SingleSkill(index: 3, name: "斧", initialVal: 15, groupIndex: combatIndex),
      SingleSkill(index: 4, name: "剑", initialVal: 20, groupIndex: combatIndex),
      SingleSkill(index: 5, name: "绞索", initialVal: 15, groupIndex: combatIndex),
      SingleSkill(index: 6, name: "链枷", initialVal: 10, groupIndex: combatIndex),
      SingleSkill(index: 7, name: "矛", initialVal: 20, groupIndex: combatIndex),
    ];
    _shooting = [
      SingleSkill(index: 0, name: "步枪/散弹枪", initialVal: 25, groupIndex: shootingIndex),
      SingleSkill(index: 1, name: "冲锋枪", initialVal: 15, groupIndex: shootingIndex),
      SingleSkill(index: 2, name: "弓术", initialVal: 15, groupIndex: shootingIndex),
      SingleSkill(index: 3, name: "喷射器", initialVal: 10, groupIndex: shootingIndex),
      SingleSkill(index: 4, name: "机枪", initialVal: 10, groupIndex: shootingIndex),
      SingleSkill(index: 5, name: "手枪", initialVal: 20, groupIndex: shootingIndex),
      SingleSkill(index: 6, name: "重武器", initialVal: 10, groupIndex: shootingIndex),
    ];
    _foreignLanguages = [];
    _drive = [
      SingleSkill(index: 0, name: "飞行器", initialVal: 1, groupIndex: driveIndex),
      SingleSkill(index: 1, name: "船", initialVal: 1, groupIndex: driveIndex)
    ];
    _science = [
      SingleSkill(index: 0, name: "地质学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 1, name: "化学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 2, name: "生物学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 3, name: "数学", initialVal: 10, groupIndex: scienceIndex),
      SingleSkill(index: 4, name: "天文学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 5, name: "物理学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 6, name: "药学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 7, name: "植物学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 8, name: "动物学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 9, name: "密码学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 10, name: "工程学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 11, name: "气象学", initialVal: 1, groupIndex: scienceIndex),
      SingleSkill(index: 12, name: "司法科学", initialVal: 1, groupIndex: scienceIndex),
    ];
    _survive = [
      SingleSkill(index: 0, name: "海上", initialVal: 10, groupIndex: surviveIndex),
    ];
    // endregion

    // region Initialize skill list
    skillList = [
      SingleSkill(index: 0, name: "会计", initialVal: 5),
      SingleSkill(index: 1, name: "人类学", initialVal: 1),
      SingleSkill(index: 2, name: "估价", initialVal: 5),
      SingleSkill(index: 3, name: "考古学", initialVal: 1),
      GroupSkill(index: 4, name: "技艺", childSkills: _artAndCraft),
      SingleSkill(index: 5, name: "取悦", initialVal: 15),
      SingleSkill(index: 6, name: "攀爬", initialVal: 20),
      SingleSkill(index: 7, name: "计算机使用", initialVal: 5),
      SingleSkill(index: 8, name: "信用评级", initialVal: 0),
      SingleSkill(index: 9, name: "克苏鲁神话", initialVal: 0),
      SingleSkill(index: 10, name: "乔装", initialVal: 5),
      SingleSkill(index: 11, name: "闪避", initialVal: 0),
      SingleSkill(index: 12, name: "汽车驾驶", initialVal: 20),
      SingleSkill(index: 13, name: "电器维修", initialVal: 10),
      SingleSkill(index: 14, name: "电子学", initialVal: 1),
      SingleSkill(index: 15, name: "话术", initialVal: 5),
      GroupSkill(index: 16, name: "格斗", childSkills: _combat),
      GroupSkill(index: 17, name: "射击", childSkills: _shooting),
      SingleSkill(index: 18, name: "急救", initialVal: 30),
      SingleSkill(index: 19, name: "历史", initialVal: 5),
      SingleSkill(index: 20, name: "恐吓", initialVal: 15),
      SingleSkill(index: 21, name: "跳跃", initialVal: 20),
      GroupSkill(index: 22, name: "母语", childSkills: []),
      GroupSkill(index: 23, name: "外语", childSkills: _foreignLanguages),
      SingleSkill(index: 24, name: "法律", initialVal: 5),
      SingleSkill(index: 25, name: "图书馆使用", initialVal: 20),
      SingleSkill(index: 26, name: "聆听", initialVal: 20),
      SingleSkill(index: 27, name: "锁匠", initialVal: 1),
      SingleSkill(index: 28, name: "机械维修", initialVal: 10),
      SingleSkill(index: 29, name: "医学", initialVal: 1),
      SingleSkill(index: 30, name: "博物学", initialVal: 10),
      SingleSkill(index: 31, name: "导航", initialVal: 10),
      SingleSkill(index: 32, name: "神秘学", initialVal: 5),
      SingleSkill(index: 33, name: "操作重型机械", initialVal: 1),
      SingleSkill(index: 34, name: "说服", initialVal: 10),
      GroupSkill(index: 35, name: "驾驶", childSkills: _drive),
      SingleSkill(index: 36, name: "精神分析", initialVal: 1),
      SingleSkill(index: 37, name: "心理学", initialVal: 10),
      SingleSkill(index: 38, name: "骑术", initialVal: 5),
      GroupSkill(index: 39, name: "科学", childSkills: _science),
      SingleSkill(index: 40, name: "妙手", initialVal: 10),
      SingleSkill(index: 41, name: "侦查", initialVal: 25),
      SingleSkill(index: 42, name: "潜行", initialVal: 20),
      GroupSkill(index: 43, name: "生存", childSkills: _survive),
      SingleSkill(index: 44, name: "游泳", initialVal: 20),
      SingleSkill(index: 45, name: "投掷", initialVal: 20),
      SingleSkill(index: 46, name: "追踪", initialVal: 10),
      SingleSkill(index: 47, name: "驯兽", initialVal: 5),
      SingleSkill(index: 48, name: "潜水", initialVal: 1),
      SingleSkill(index: 49, name: "爆破", initialVal: 1),
      SingleSkill(index: 50, name: "读唇", initialVal: 1),
      SingleSkill(index: 51, name: "催眠", initialVal: 1),
      SingleSkill(index: 52, name: "炮术", initialVal: 1),
      GroupSkill(index: 53, name: "学识", childSkills: [])
    ];
    // endregion
  }

  int get usedOccuVal {
    int usedOccuVal = 0;

    skillList.forEach((skill){
      if (skill is GroupSkill) {
        GroupSkill groupSkill = skill;
        skill.childSkills.forEach((singleSkill){
          usedOccuVal += singleSkill.occuVal;
        });
      } else {
        SingleSkill singleSkill = skill;
        usedOccuVal += singleSkill.occuVal;
      }
    });

    return usedOccuVal;
  }

  int get usedInterestVal {
    int usedInterestVal = 0;

    skillList.forEach((skill){
      if (skill is GroupSkill) {
        GroupSkill groupSkill = skill;
        skill.childSkills.forEach((singleSkill){
          usedInterestVal += singleSkill.interestVal;
        });
      } else {
        SingleSkill singleSkill = skill;
        usedInterestVal += singleSkill.interestVal;
      }
    });

    return usedInterestVal;
  }

  factory SkillManager.fromJson(Map<String, dynamic> json) => _$SkillManagerFromJson(json);

  Map<String, dynamic> toJson() => _$SkillManagerToJson(this);
}