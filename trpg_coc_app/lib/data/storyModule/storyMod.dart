import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';
import "package:data_plugin/data_plugin.dart";
import 'package:trpgcocapp/data/coc_file.dart';
import '../roleCard/roleCard.dart';
class StoryMap<T  extends COCFile> {

  StoryMap();
  T mapImg;
  List<StoryScene<T>> scenes=new List<StoryScene<T>>();
  void addScene(StoryScene<T> scene){
    this.scenes.add(scene);
  }
}
class StoryScene<T  extends COCFile>{
  String name;
  int mainSceneIdx=0;
  double xPosition;
  double yPosition;
  List<StorySubScene<T>> subScenes=[];
  List<int> npcsId=[];

  StoryScene(this.name,this.mainSceneIdx,this.npcsId,this.xPosition, this.yPosition);


}
class StorySubScene<T  extends COCFile>{
  String name='undefined';
  T bgImg;
  StorySubScene(this.name);
}

class StoryMod<T  extends COCFile> extends BmobObject{
  StoryMap<T> map;

  StoryMod(this.npcs,this.map,this.moduleName, this.estimate_hours,
      this.kpHourMin, this.plHourMin);

  List<roleCard> npcs=[];
  String moduleName='undefined';
  String descript = '';
  T thumbnailImg;
  int estimate_hours;
  int kpHourMin;
  int plHourMin;


  @override
  Map getParams() {
    // TODO: implement getParams
    return null;
  }
}