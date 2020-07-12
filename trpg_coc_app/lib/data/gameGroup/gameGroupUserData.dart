
import 'dart:convert';

import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import '../storyModule/storyModOnUse.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:json_annotation/json_annotation.dart';

part 'gameGroupUserData.g.dart';
enum gameGroupIdentity{
@JsonValue(0)
Manager,
@JsonValue(1)
Player,
}
@JsonSerializable()
class gameGroupUserData extends BmobObject{
  int groupID = -1;
  int userID=-1;
  int roleID=-1;
  gameGroupIdentity identity=gameGroupIdentity.Player;
//  BmobFile avatar=BmobFile();
  factory gameGroupUserData.fromJson(Map<String, dynamic> json) => _$gameGroupUserDataFromJson(json);
  Map<String, dynamic> toJson() => _$gameGroupUserDataToJson(this);
  @override
  Map getParams() {
    return toJson();
  }
  gameGroupUserData();
  gameGroupUserData.full(this.groupID, this.userID, this.roleID, this.identity);
}