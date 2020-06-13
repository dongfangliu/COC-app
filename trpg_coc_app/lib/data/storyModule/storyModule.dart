import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
import '../roleCard/roleCard.dart';
class storyMap{
  storyModule module;

  storyMap(this.module);

  BmobFile bgImageURL=BmobFile();
  List<storyScene> scenes=new List<storyScene>();
  void addScene(storyScene scene){
    this.scenes.add(scene);
  }
}
class storyScene{
  storyMap map;
  String name;
//  int iconType=0;// 0000 is  point ,4 bit correspond to left,right,up,down
  int mainSceneIdx=0;
  double xPosition;
  double yPosition;
  List<storySubScene> subScenes=[];
  List<int> npcsId=[];

  storyScene(this.map, this.name, this.xPosition, this.yPosition);


}
class storySubScene{
  storyScene scene;
  String name='undefined';
  BmobFile bgImg=BmobFile();

  storySubScene(this.scene, this.name);


}

class storyModule{
  storyMap map;
  List<roleCard> npcs=[];
  String moduleName='undefined';
  BmobFile thumbnailImg=BmobFile();
  int estimate_hours;
  int kpHourMin;
  int plHourMin;

  storyModule();

  void addMap(){
    this.map = new storyMap(this);
  }
}
