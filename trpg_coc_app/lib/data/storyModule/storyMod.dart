import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
import 'package:trpgcocapp/data/coc_file.dart';
import '../roleCard/roleCard.dart';
class StoryMap<T  extends CoCFile> {

  StoryMap();
  T bgImage;
  List<StoryScene> scenes=new List<StoryScene>();
  void addScene(StoryScene<T> scene){
    this.scenes.add(scene);
  }
}
class StoryScene<T  extends CoCFile>{
  String name;
  int mainSceneIdx=0;
  double xPosition;
  double yPosition;
  List<StorySubScene<T>> subScenes=[];
  List<int> npcsId=[];

  StoryScene(this.name,this.mainSceneIdx,this.npcsId,this.xPosition, this.yPosition);


}
class StorySubScene<T  extends CoCFile>{
  String name='undefined';
  T bgImg;

  StorySubScene(this.name);
}

class StoryMod<T  extends CoCFile>{
  StoryMap<T> map;

  StoryMod(this.npcs, this.moduleName, this.estimate_hours,
      this.kpHourMin, this.plHourMin);

  List<roleCard> npcs=[];
  String moduleName='undefined';
  T thumbnailImg;
  int estimate_hours;
  int kpHourMin;
  int plHourMin;

  void addMap(){
    this.map = new StoryMap<T>();
  }
}
