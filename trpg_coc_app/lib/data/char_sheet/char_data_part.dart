// library char_sheet_data;

import 'dart:math';

import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/skills.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/occupations.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/weapons.dart';
/*
part 'info_data.dart';
part 'attr_data.dart';
part 'occu_data.dart';
part 'skill_data.dart';
part 'combat_data.dart';
part 'invt_data.dart';
part 'story_data.dart';
*/

abstract class CharDataPart extends BmobObject{
  bool isFinished();
}