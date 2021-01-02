import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trpgcocapp/data/char_sheet/char_data.dart';
import 'package:trpgcocapp/data/file/coc_file.dart';

part 'storyMod.g.dart';

enum ModEra {
  @JsonValue("1920s")
  NINETEENTH,
  @JsonValue("modern")
  MODERN,
  @JsonValue("others")
  OTHERS,
  @JsonValue("present")
  PPRESENT
}
const Map<ModEra, String> ModEraText = {
  ModEra.NINETEENTH: "1920s",
  ModEra.MODERN: "现代",
  ModEra.PPRESENT: "当代",
  ModEra.OTHERS: "其他",
};
enum ModRegion {
  @JsonValue("America")
  America,
  @JsonValue("Europe")
  Europe,
  @JsonValue("China")
  China,
  @JsonValue("Japan")
  Japan,
  @JsonValue("others")
  others
}

const Map<ModRegion, String> ModRegionText = {
  ModRegion.America: "美国",
  ModRegion.Europe: "欧洲",
  ModRegion.China: "中国",
  ModRegion.Japan: "日本",
  ModRegion.others: "其他",
};

@JsonSerializable()
class StoryMap{
  StoryMap();

  COC_File mapImg=COC_File.Asset(url:"assets/images/map.png");
  List<StoryScene> scenes = new List<StoryScene>();
  void addScene(StoryScene scene) {
    this.scenes.add(scene);
  }

  factory StoryMap.fromJson(Map<String, dynamic> json) =>
      _$StoryMapFromJson(json);

  Map<String, dynamic> toJson() => _$StoryMapToJson(this);
}

@JsonSerializable()
class StoryScene {
  String name;
  int mainSceneIdx = 0;
  double xPosition;
  double yPosition;
  List<StorySubScene> subScenes = [];
  List<int> npcsId = [];

  StoryScene(this.name, this.mainSceneIdx, this.npcsId, this.xPosition,
      this.yPosition);

  factory StoryScene.fromJson(Map<String, dynamic> json) =>
      _$StorySceneFromJson(json);

  Map<String, dynamic> toJson() => _$StorySceneToJson(this);
}

@JsonSerializable()
class StorySubScene {
  String name = 'undefined';
  COC_File bgImg=COC_File.Asset(url:"assets/images/subscenebg.jpg");
  StorySubScene(this.name);
  factory StorySubScene.fromJson(Map<String, dynamic> json) =>
      _$StorySubSceneFromJson(json);

  Map<String, dynamic> toJson() => _$StorySubSceneToJson(this);
}

@JsonSerializable()
class StoryMod extends BmobObject {
  StoryMap map;
  StoryMod(this.npcs, this.moduleName, this.hours_min, this.hours_max,
      this.people_min, this.people_max, this.likes);
  List<CharDataTemplate> npcs = [];
  String moduleName = 'undefined';
  String descript = '';
  COC_File thumbnailImg=COC_File.Asset(url:"assets/images/map.png");
  COC_File iconImg=COC_File.Asset(url:"assets/images/defaultModIcon.png");
  int hours_min = 0;
  int hours_max = 0;
  int people_min = 0;
  int people_max = 0;
  String author = "hidden";
  int likes = 0;
  ModEra era = ModEra.NINETEENTH;
  ModRegion region = ModRegion.Europe;
  List<String> tags = [];
  // should add use
  factory StoryMod.fromJson(Map<String, dynamic> json) =>
      _$StoryModFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModToJson(this);

  @override
  Map getParams() {
    return toJson();
  }
  String getPeopleRangeText()=>people_min.toString()+"-"+people_max.toString();
  String getHourRangeText()=>hours_min.toString()+"-"+hours_max.toString();

}
//
//T _dataFromJson(Map<String, dynamic> input) => input['value'] as T;
//
//Map<String, dynamic> _dataToJson(T input) => {'value': input};
