import "package:leancloud_storage/leancloud.dart";
abstract class lc_class{
  String objectId;
  LCObject object;
  void toLCObject();
  void fromLCObject();
  void _onModified();
}
class coc_user{
  List<int> my_groupsId;
  List<int> my_modsId;
  String lastLoginTime;
}
abstract class diceable{
  bool dice(int dice_num,int dice_range,int targetValue,int level);
}
class common_attribute extends diceable{
  int value;
  @override
  bool dice(int dice_num, int dice_range, int targetValue, int level) {
    // TODO: implement dice
    return null;
  }
}

class skill extends diceable{
  roleCard card;
  String name;
  int baseValue;
  int intrestPoint;
  int occupationPoint;
  int get value{return baseValue+intrestPoint+occupationPoint;}
  @override
  bool dice(int dice_num, int dice_range, int targetValue, int level) {
    // TODO: implement dice
    return null;
  }
}
class buff{
  String description;
}
class packable{
  String name;
  String description;
  int num;
  String loc;
}
class roleCard extends lc_class{
  common_attribute hp, mp,san,luck;
  common_attribute strength,constitution,size,appearance,intelligence,willpower,education,agility;
  bool alive;
  String name;
  String hometown;
  int age;
  int gender;
  String occupation;
  String Residence;
  String era;
  String description;
  List<packable>  backpack;
  List<skill> skills;
  String additionInfo;

  @override
  void _onModified() {
    // TODO: implement _onModified
  }

  @override
  void fromLCObject() {
    // TODO: implement fromLCObject
  }

  @override
  void toLCObject() {
    // TODO: implement toLCObject
  }
}

class storyMap{
  String bgImageURL;
  List<storyScene> scenes;
}
class storyScene{
  storyMap map;
  int bgPosx,bgPosy;
  String fgImageURL;// foreground
  String bgImageURL;// background
  List<int> npcsId;
}
class storyModule extends lc_class{
  storyMap map;
  List<roleCard> npcs;
  String moduleName;
  String snapShotImageURL;

  @override
  void _onModified() {
    // TODO: implement _onModified
  }

  @override
  void fromLCObject() {
    // TODO: implement fromLCObject
  }

  @override
  void toLCObject() {
    // TODO: implement toLCObject
  }
}

class COCGroupComment{

}
class history{

}

class COCGroup{
  int status;//0=招募中，1=已招满，2=进行中，3=已结束
  storyModule module;
  String description;
  String note;//其他一些备注信息
List<coc_user> participants;//0 is KP/GM
String lastActiveTime;
  List<COCGroupComment> comments;
  history hist;

}




