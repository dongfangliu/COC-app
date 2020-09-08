//part of 'char_data_part.dart';

import 'char_data_part.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_data.g.dart';

@JsonSerializable()
class StoryData extends CharDataPart {
  final List<String> storyTitles = [
    "Personal Description",
    "Ideology/Belifs",
    "Signigicant People",
    "Meaningful Locations",
    "Treasured Possessions",
    "Traits",
    "Injuries & Scars",
    "Phobias & Manias",
    "Arcane Tomes, Spells & Artifacts",
    "Encounters with Strange Entities"
  ];
  List<String> stories = []; // Manage all the stories

  int criticalConnection;

  String _personalDescription = "";
  String _ideology = "";
  String _significantPeople = "";
  String _meaningfulLocations = "";
  String _treasuredPossessions = "";
  String _traits = "";
  String _injuries = "";        // Not necessary
  String _phobias = "";         // Not necessary
  String _artifacts = "";       // Not necessary
  String _strangeEntities = ""; // Not necessary

  StoryData(){
    stories = [
      _personalDescription,
      _ideology,
      _significantPeople,
      _meaningfulLocations,
      _treasuredPossessions,
      _traits,
      _injuries,
      _phobias,
      _artifacts,
      _strangeEntities,
    ];
  }

  bool isFinished() {
    if (stories[0] == "" ||
        stories[1] == "" ||
        stories[2] == "" ||
        stories[3] == "" ||
        stories[4] == "" ||
        stories[5] == "") {
      return false;
    } else {
      return true;
    }
  }

  @override
  Map getParams() {
    // TODO: implement getParams
    throw UnimplementedError();
  }

  factory StoryData.fromJson(Map<String, dynamic> json) => _$StoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$StoryDataToJson(this);
}