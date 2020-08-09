import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trpgcocapp/data/coc_file.dart';
import 'package:trpgcocapp/data/roleCard/roleCard.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';

part 'storyModOnUse.g.dart';

@JsonSerializable()
class StoryMapUsing extends StoryMap<COCBmobServerFile> {
  StoryMapUsing() : super() {
  }

  from(StoryMapCreate mapCreate)async {
    this.mapImg = new COCBmobServerFile();
    await this.mapImg.from(mapCreate.mapImg.file);

    this.scenes = new List<StorySceneUsing>();
    for(int i = 0; i<mapCreate.scenes.length;i++){
      StorySceneCreate sceneCreate = mapCreate.scenes[i];
      StorySceneUsing sceneUsing = new StorySceneUsing(sceneCreate.name,sceneCreate.mainSceneIdx,sceneCreate.npcsId,sceneCreate.xPosition,sceneCreate.yPosition);
      await sceneUsing.from(sceneCreate);
      this.scenes.add(sceneUsing);
    }
  }

}

@JsonSerializable()
class StorySceneUsing extends StoryScene<COCBmobServerFile> {
  StorySceneUsing(String name, int mainSceneIdx, List<int> npcsId, double xPosition, double yPosition) : super(name, mainSceneIdx, npcsId, xPosition, yPosition);


  from(StorySceneCreate sceneCreate) async {
    this.subScenes = new List<StorySubSceneUsing>();
    for(int i = 0; i<sceneCreate.subScenes.length;i++){
      StorySubSceneUsing subSceneUsing = new StorySubSceneUsing(sceneCreate.subScenes[i].name);
      await subSceneUsing.from(sceneCreate.subScenes[i]);
      this.subScenes.add(subSceneUsing);
    }
  }
}

@JsonSerializable()
class StorySubSceneUsing extends StorySubScene<COCBmobServerFile> {
  StorySubSceneUsing(String name)
      : super(name) {
  }

  from(StorySubSceneCreate sceneCreate)
     async {
    this.bgImg =new  COCBmobServerFile();
    await this.bgImg.from(sceneCreate.bgImg.file);
  }
}

@JsonSerializable()
class StoryModUsing extends StoryMod<COCBmobServerFile> {
  StoryModUsing(List<roleCard> npcs, String moduleName, int hours_min,int hours_max,
      int people_min,int people_max,int likes) :
        super(npcs, moduleName, hours_min, hours_max, people_min,people_max,likes);

  from(StoryModCreate modCreate) async {
   this.thumbnailImg= COCBmobServerFile();
   await this.thumbnailImg.from(modCreate.thumbnailImg.file);
   StoryMapUsing mapUsing =new StoryMapUsing();
   await  mapUsing.from(modCreate.map);
   this.map = mapUsing;
  }



  factory StoryModUsing.fromJson(Map<String, dynamic> json) => _$StoryModUsingFromJson(json);
  Map<String, dynamic> toJson() => _$StoryModUsingToJson(this);
}


T _dataFromJson<T>(Map<String, dynamic> input) =>
    input['value'] as T;

Map<String, dynamic> _dataToJson<T>(T input) =>
    {'value': input};
