import 'package:trpgcocapp/data/coc_file.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';

class StoryMapUsing extends StoryMap<COCBmobFile> {
  StoryMapUsing() : super() {
    this.bgImage = new COCBmobFile();
  }

  StoryMapUsing.from(StoryMapCreate mapCreate) : super(){

    this.bgImage = new COCBmobFile();
    this.bgImage.fromLocalFile(mapCreate.bgImage.file);
    this.scenes = mapCreate.scenes.map((scene){
      return StorySceneUsing.from(scene);
    }).toList();
  }

}

class StorySceneUsing extends StoryScene<COCBmobFile> {

  StorySceneUsing.from(StorySceneCreate sceneCreate)
      : super(sceneCreate.name,sceneCreate.mainSceneIdx,sceneCreate.npcsId, sceneCreate.xPosition,
            sceneCreate.yPosition){
    this.subScenes = sceneCreate.subScenes.map((subscene){
      return StorySubSceneUsing.from(subscene);
    }).toList();
  }
}

class StorySubSceneUsing extends StorySubScene<COCBmobFile> {
  StorySubSceneUsing(String name)
      : super(name) {
    this.bgImg = COCBmobFile();
  }

  StorySubSceneUsing.from(
      StorySubSceneCreate sceneCreate)
      : super(sceneCreate.name) {
    this.bgImg = COCBmobFile();
    this.bgImg.fromLocalFile(sceneCreate.bgImg.file);
  }
}

class StoryModUsing extends StoryMod<COCBmobFile> {

  StoryModUsing.from(StoryModCreate modCreate) : super(modCreate.npcs,modCreate. moduleName,modCreate.estimate_hours, modCreate.kpHourMin, modCreate.plHourMin){
   this.thumbnailImg= COCBmobFile();
   this.thumbnailImg.fromLocalFile(modCreate.thumbnailImg.file);
   this.map = StoryMapUsing.from(modCreate.map );
  }
}
