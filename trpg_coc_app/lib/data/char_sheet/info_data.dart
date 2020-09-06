//part of 'char_data_part.dart';

import 'package:json_annotation/json_annotation.dart';
import 'char_data_part.dart';

part 'info_data.g.dart';

@JsonSerializable()
class InfoData extends CharDataPart {
  String name = "";
  String era = "";
  int age = 0;
  String sex = "";
  String residence = "";
  String birthplace = "";

  InfoData();

  @override
  bool isFinished() {
    if (name == "" ||
        era == "" ||
        age == 0 ||
        sex == "" ||
        residence == "" ||
        birthplace == "") {
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

  factory InfoData.fromJson(Map<String, dynamic> json) => _$InfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$InfoDataToJson(this);
}