import 'package:data_plugin/bmob/bmob.dart';
import 'package:trpgcocapp/bloc/module_creation/module_creation_repository.dart';
import 'package:trpgcocapp/data/file/coc_file.dart';
import 'package:trpgcocapp/data/roleCard/roleCard.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';

class StoryMapCreate extends StoryMap<COCBmobEditable> {
  StoryMapCreate() : super() {
    this.scenes = new List<StorySceneCreate>();
    this.mapImg = new COCBmobEditable.AssetImage(defaultFilePath: "assets/images/map.png");
  }
}

class StorySceneCreate extends StoryScene<COCBmobEditable> {
  StorySceneCreate(String name, int mainSceneIdx, List<int> npcsId,
      double xPosition, double yPosition)
      : super(name, mainSceneIdx, npcsId, xPosition, yPosition) {
    this.subScenes.add(StorySubSceneCreate("default"));
  }
}

class StorySubSceneCreate extends StorySubScene<COCBmobEditable> {
  StorySubSceneCreate(String name) : super(name) {
    this.bgImg = new COCBmobEditable.AssetImage(
        defaultFilePath: "assets/images/subscenebg.jpg");
  }
}

class StoryModCreate extends StoryMod<COCBmobEditable> {
  StoryModCreate(List<roleCard> npcs, String moduleName, int hours_min,
      int hours_max, int people_min, int people_max, int likes)
      : super(npcs, moduleName, hours_min, hours_max, people_min, people_max,
            likes) {
    this.map = new StoryMapCreate();
    this.thumbnailImg =
        new COCBmobEditable.AssetImage(defaultFilePath: "assets/images/add.png");
    this.iconImg = new COCBmobEditable.AssetImage(
        defaultFilePath: "assets/images/defaultModIcon.png");
  }
}
