import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
import '../roleCard/roleCard.dart';
class StoryMap{
  StoryMod module;

  StoryMap(this.module);

  BmobFile bgImageURL=BmobFile();
  List<StoryScene> scenes=new List<StoryScene>();
  void addScene(StoryScene scene){
    this.scenes.add(scene);
  }
}
class StoryScene{
  StoryMap map;
  String name;
  int mainSceneIdx=0;
  double xPosition;
  double yPosition;
  List<StorySubScene> subScenes=[];
  List<int> npcsId=[];

  StoryScene(this.map, this.name, this.xPosition, this.yPosition);


}
class StorySubScene{
  StoryScene scene;
  String name='undefined';
  BmobFile bgImg=BmobFile();

  StorySubScene(this.scene, this.name);
}

class StoryMod{
  StoryMap map;
  List<roleCard> npcs=[];
  String moduleName='undefined';
  BmobFile thumbnailImg=BmobFile();
  int estimate_hours;
  int kpHourMin;
  int plHourMin;

  StoryMod();

  void addMap(){
    this.map = new StoryMap(this);
  }
}
