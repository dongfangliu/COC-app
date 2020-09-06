//part of 'char_data_part.dart';
import 'char_data_part.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/weapons.dart';

import 'package:json_annotation/json_annotation.dart';

part 'combat_data.g.dart';

@JsonSerializable()
class CombatData extends CharDataPart {
  List<Weapon> weaponList = [];

  CombatData();

  bool isFinished() {
    if (weaponList.length == 0) {
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

  factory CombatData.fromJson(Map<String, dynamic> json) => _$CombatDataFromJson(json);

  Map<String, dynamic> toJson() => _$CombatDataToJson(this);
}