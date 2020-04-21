import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
import "roleCard.dart";
class storyMap{
  BmobFile bgImageURL;
  List<storyScene> scenes;
}
class storyScene{
  storyMap map;
  int bgPosx,bgPosy;
  BmobFile fgImageURL;// foreground
  BmobFile bgImageURL;// background
  List<roleCard> npcs;
}
class storyModule{
  storyMap map;
  List<roleCard> npcs;
  String moduleName;
  BmobFile snapShotImageURL;
}
