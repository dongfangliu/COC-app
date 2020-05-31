import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
import '../roleCard/roleCard.dart';
class storyMap{
  BmobFile bgImageURL=BmobFile();
  int gridx=80;
  int gridy=60;
  List<storyScene> scenes=[];
  List<int> sceneIdx=[];
  void addScene(storyScene scene){
    this.scenes.add(scene);
    this.sceneIdx.add(scene.idx);
  }
}
class storyScene{
  String name;
//  int iconType=0;// 0000 is  point ,4 bit correspond to left,right,up,down
  int idx;
  int mainSceneIdx=0;
  List<storySubScene> subScenes=[];
  List<int> npcsId=[];

  storyScene(this.name, this.idx);
}
class storySubScene{
  BmobFile bgImg=BmobFile();

  storySubScene(this.name);

  String name='undefined';
}

class storyModule{
  storyMap map=storyMap();
  List<roleCard> npcs=[];
  String moduleName='undefined';
  BmobFile thumbnailImg=BmobFile();
  int estimate_hours;
  int kpHourMin;
  int plHourMin;
}
