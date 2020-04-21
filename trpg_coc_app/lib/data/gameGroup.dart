import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
enum gameGroupIdentity{
  Manager,Player
}
class gameGroup_UserData{
  int groupID;
  int userID;
  int roleID;
  gameGroupIdentity identity;
  BmobFile avatar;
}
enum gameGroupStatus{
  HIRING,HIRED_FULL,ONGOING,ARCHIVED//0=招募中，1=已招满，2=进行中，3=已结束
}
class gameParamSetting{

}
class gameGroup{
  gameGroupStatus status;
  int roomID;
  int moduleID;
  String description;
  String note;//其他一些备注信息
  List<gameGroup_UserData> participants;//0 is KP/GM
  gameParamSetting setting;
  String lastActiveTime;
}