
import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'storyModule.dart';
enum gameGroupIdentity{
  Manager,Player
}
class gameGroup_UserData{
  int groupID = -1;
  int userID=-1;
  int roleID=-1;
  gameGroupIdentity identity=gameGroupIdentity.Player;
  BmobFile avatar=BmobFile();
}
enum gameGroupStatus{
  HIRING,HIRED_FULL,ONGOING,ARCHIVED//0=招募中，1=已招满，2=进行中，3=已结束
}
class gameParamSetting{

}
class gameGroup{
  String name="";
  gameGroupStatus status;
  int roomID=-1;
  storyModule module=storyModule();
  String description="";
  String note="";//其他一些备注信息
  List<gameGroup_UserData> participants=[];//0 is KP/GM
  gameParamSetting setting=gameParamSetting();
  String lastActiveTime="2018-02-02";
  int estimatedTimeLength = 10;
  String startTime="2018-02-02";
  int minSize=0,maxSize=10;
}