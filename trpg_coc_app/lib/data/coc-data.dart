import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
import 'package:json_annotation/json_annotation.dart';
import 'roleCard.dart';
import 'chatRoom.dart';
import 'storyModule.dart';
class trpgUser extends BmobUser{
  BmobFile mIcon;
  List<UserGroupData> mGroups;
  List<storyModule> mMods;
  String lastLoginTime;
}




