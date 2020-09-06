//part of 'char_data_part.dart';
import 'char_data_part.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attr_data.g.dart';

@JsonSerializable()
class AttrData extends CharDataPart {
  num str = 0;  // 力量
  num con = 0;  // 体质
  num siz = 0;  // 体型
  num dex = 0;  // 敏捷
  num app = 0;  // 外貌
  num int = 0;  // 智力
  num pow = 0;  // 意志
  num edu = 0;  // 教育
  num luc = 0;  // 幸运

  num get mov {
    if (dex == 0 || str == 0 || siz == 0){
      return 0;
    } else {
      if (dex < siz && str < siz) {
        return 7;
      } else if (dex > siz || str > siz) {
        return 9;
      } else {
        return 8;
      }
    }
  } // 移动力

  num get san {
    return pow;
  }          // 理智
  num get hitPoints {
    if (con == 0 || siz == 0) {
      return 0;
    } else {
      return ((con + siz) / 10).floor();
    }
  }    // 体力
  num get magicPoints{
    return (pow / 5).floor();
  }   // 魔力

  // Combat attributes
  String get damageBonus {
    num _strPlusSiz = str + siz;
    if (_strPlusSiz <= 64) {
      return "-2";
    } else if (65 <= _strPlusSiz && _strPlusSiz <= 84) {
      return "-1";
    } else if (85 <= _strPlusSiz && _strPlusSiz <= 124) {
      return "0";
    } else if (125 <= _strPlusSiz && _strPlusSiz <= 164) {
      return "+1d4";
    } else if (165 <= _strPlusSiz && _strPlusSiz <= 204) {
      return "+1d6";
    } else if (205 <= _strPlusSiz && _strPlusSiz <= 284) {
      return "+2d6";
    } else if (285 <= _strPlusSiz && _strPlusSiz <= 364) {
      return "+3d6";
    } else if (365 <= _strPlusSiz && _strPlusSiz <= 444) {
      return "+4d6";
    } else if (445 <= _strPlusSiz && _strPlusSiz <= 524) {
      return "+5d6";
    } else {
      return "OutOfChart";
    }
  } // 伤害加值
  String get build{
    num _strPlusSiz = str + siz;
    if (_strPlusSiz <= 64) {
      return "-2";
    } else if (65 <= _strPlusSiz && _strPlusSiz <= 84) {
      return "-1";
    } else if (85 <= _strPlusSiz && _strPlusSiz <= 124) {
      return "0";
    } else if (125 <= _strPlusSiz && _strPlusSiz <= 164) {
      return "+1";
    } else if (165 <= _strPlusSiz && _strPlusSiz <= 204) {
      return "+2";
    } else if (205 <= _strPlusSiz && _strPlusSiz <= 284) {
      return "+3";
    } else if (285 <= _strPlusSiz && _strPlusSiz <= 364) {
      return "+4";
    } else if (365 <= _strPlusSiz && _strPlusSiz <= 444) {
      return "+5";
    } else if (445 <= _strPlusSiz && _strPlusSiz <= 524) {
      return "+6";
    } else {
      return "OutOfChart";
    }
  }        // 体格
  num get dodge{
    return (dex / 2).floor();
  }           // 闪避

  AttrData();

  @override
  bool isFinished() {
    if (str == 0 || str == null ||
        con == 0 || con == null ||
        siz == 0 || siz == null ||
        dex == 0 || dex == null ||
        app == 0 || app == null ||
        int == 0 || int == null ||
        pow == 0 || pow == null ||
        edu == 0 || edu == null ||
        luc == 0 || luc == null) {
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

  factory AttrData.fromJson(Map<String, dynamic> json) => _$AttrDataFromJson(json);

  Map<String, dynamic> toJson() => _$AttrDataToJson(this);
}