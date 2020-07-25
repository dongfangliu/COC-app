import 'package:trpgcocapp/data/coc_file.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';

class StoryMapUsing extends StoryMap<COCBmobServerFile> {
  StoryMapUsing() : super() {
  }

  StoryMapUsing.from(StoryMapCreate mapCreate) : super(){
    this.mapImg = new COCBmobServerFile.from(mapCreate.mapImg.file);
    this.scenes = mapCreate.scenes.map((scene){
      return StorySceneUsing.from(scene);
    }).toList();
  }

}

class StorySceneUsing extends StoryScene<COCBmobServerFile> {

  StorySceneUsing.from(StorySceneCreate sceneCreate)
      : super(sceneCreate.name,sceneCreate.mainSceneIdx,sceneCreate.npcsId, sceneCreate.xPosition,
            sceneCreate.yPosition){
    this.subScenes = sceneCreate.subScenes.map((subscene){
      return StorySubSceneUsing.from(subscene);
    }).toList();
  }
}

class StorySubSceneUsing extends StorySubScene<COCBmobServerFile> {
  StorySubSceneUsing(String name)
      : super(name) {
  }

  StorySubSceneUsing.from(
      StorySubSceneCreate sceneCreate)
      : super(sceneCreate.name) {
    this.bgImg = COCBmobServerFile.from(sceneCreate.bgImg.file);
  }
}

class StoryModUsing extends StoryMod<COCBmobServerFile> {
  StoryModUsing.from(StoryModCreate modCreate) : super(modCreate.npcs,StoryMapUsing.from(modCreate.map ),modCreate. moduleName,modCreate.estimate_hours, modCreate.kpHourMin, modCreate.plHourMin){
   this.thumbnailImg= COCBmobServerFile.from(modCreate.thumbnailImg.file);
  }
}
