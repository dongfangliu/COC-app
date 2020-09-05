import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trpgcocapp/data/coc_file.dart';
import '../roleCard/roleCard.dart';

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
class StoryMap<T extends COCFile> {
  StoryMap();

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T mapImg;
  List<StoryScene<T>> scenes = new List<StoryScene<T>>();
  void addScene(StoryScene<T> scene) {
    this.scenes.add(scene);
  }

  factory StoryMap.fromJson(Map<String, dynamic> json) =>
      _$StoryMapFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StoryMapToJson(this);
}

@JsonSerializable()
class StoryScene<T extends COCFile> {
  String name;
  int mainSceneIdx = 0;
  double xPosition;
  double yPosition;
  List<StorySubScene<T>> subScenes = [];
  List<int> npcsId = [];

  StoryScene(this.name, this.mainSceneIdx, this.npcsId, this.xPosition,
      this.yPosition);

  factory StoryScene.fromJson(Map<String, dynamic> json) =>
      _$StorySceneFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StorySceneToJson(this);
}

@JsonSerializable()
class StorySubScene<T extends COCFile> {
  String name = 'undefined';
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T bgImg;
  StorySubScene(this.name);
  factory StorySubScene.fromJson(Map<String, dynamic> json) =>
      _$StorySubSceneFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StorySubSceneToJson(this);
}

@JsonSerializable()
class StoryMod<T extends COCFile> extends BmobObject {
  StoryMap<T> map;
  StoryMod(this.npcs, this.moduleName, this.hours_min, this.hours_max,
      this.people_min, this.people_max, this.likes);
  List<roleCard> npcs = [];
  String moduleName = 'undefined';
  String descript = '';
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T thumbnailImg;
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T iconImg;
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
      _$StoryModFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StoryModToJson(this);

  @override
  Map getParams() {
    return toJson();
  }
  String getPeopleRangeText()=>people_min.toString()+"-"+people_max.toString();
  String getHourRangeText()=>hours_min.toString()+"-"+hours_max.toString();

}

T _dataFromJson<T>(Map<String, dynamic> input) => input['value'] as T;

Map<String, dynamic> _dataToJson<T>(T input) => {'value': input};
