import 'package:json_annotation/json_annotation.dart';

import 'buff.dart';
import 'packable.dart';
import 'skill.dart';
part 'roleCard.g.dart';

@JsonSerializable()
class roleCard {
  int hp=0, mp=0,san=0,luck=0;
  int strength=0,constitution=0,size=0,appearance=0,intelligence=0,willpower=0,education=0,agility=0;
  bool alive=false;
  String name="undefined";
  String hometown="undefined";
  int age=-1;
  int gender=-1;
  String occupation="undefined";
  String residence="undefined";
  String era="undefined";
  String description="undefined";
  List<packable>  backpack=[];
  List<skill> skills=[];
  String additionInfo="undefined";
  bool isNPC=false;

  factory roleCard.fromJson(Map<String, dynamic> json) =>
      _$roleCardFromJson(json);

  Map<String, dynamic> toJson() => _$roleCardToJson(this);

  roleCard();
}