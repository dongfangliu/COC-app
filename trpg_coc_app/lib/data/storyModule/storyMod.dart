import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trpgcocapp/data/coc_file.dart';
import '../roleCard/roleCard.dart';

part 'storyMod.g.dart';

@JsonSerializable()
class StoryMap<T  extends COCFile> {

  StoryMap();

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T mapImg;
  List<StoryScene<T>> scenes=new List<StoryScene<T>>();
  void addScene(StoryScene<T> scene){
    this.scenes.add(scene);
  }

  factory StoryMap.fromJson(Map<String, dynamic> json) =>
      _$StoryMapFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StoryMapToJson(this);
}

@JsonSerializable()
class StoryScene<T  extends COCFile>{
  String name;
  int mainSceneIdx=0;
  double xPosition;
  double yPosition;
  List<StorySubScene<T>> subScenes=[];
  List<int> npcsId=[];

  StoryScene(this.name,this.mainSceneIdx,this.npcsId,this.xPosition, this.yPosition);

  factory StoryScene.fromJson(Map<String, dynamic> json) =>
      _$StorySceneFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StorySceneToJson(this);

}

@JsonSerializable()
class StorySubScene<T  extends COCFile>{
  String name='undefined';
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T bgImg;
  StorySubScene(this.name);
  factory StorySubScene.fromJson(Map<String, dynamic> json) =>
      _$StorySubSceneFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StorySubSceneToJson(this);
}


@JsonSerializable()
class StoryMod<T  extends COCFile> extends BmobObject{
  StoryMap<T> map;
  StoryMod(this.npcs,this.moduleName, this.estimate_hours,
      this.kpHourMin, this.plHourMin);

  List<roleCard> npcs=[];
  String moduleName='undefined';
  String descript = '';
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  T thumbnailImg;
  int estimate_hours;
  int kpHourMin;
  int plHourMin;
  factory StoryMod.fromJson(Map<String, dynamic> json) =>
      _$StoryModFromJson<T>(json);

  Map<String, dynamic> toJson() => _$StoryModToJson(this);

  @override
  Map getParams() {
    return toJson();
  }
}


T _dataFromJson<T>(Map<String, dynamic> input) =>
    input['value'] as T;

Map<String, dynamic> _dataToJson<T>(T input) =>
    {'value': input};