import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
import '../roleCard/roleCard.dart';
class storyMap{
  BmobFile bgImageURL=BmobFile();
  List<storyScene> scenes=[];
}
class storyScene{
  String sceneName;
  int bgPosx,bgPosy;
  BmobFile fgImageURL=BmobFile();// foreground
  BmobFile bgImageURL=BmobFile();// background
  List<int> npcsId=[];
}
class storyModule{
  storyMap map=storyMap();
  List<roleCard> npcs=[];
  String moduleName='undefined';
  BmobFile thumbnailImg=BmobFile();
}
