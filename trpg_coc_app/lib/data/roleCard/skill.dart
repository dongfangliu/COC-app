
import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';
@JsonSerializable()
class skill {
  String name="undefined";
  int baseValue=0;
  int intrestPoint=0;
  int occupationPoint=0;
  int get value{return baseValue+intrestPoint+occupationPoint;}

  factory skill.fromJson(Map<String, dynamic> json) =>
      _$skillFromJson(json);

  Map<String, dynamic> toJson() => _$skillToJson(this);

  skill();
}