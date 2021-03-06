import 'package:json_annotation/json_annotation.dart';
import 'package:trpgcocapp/data/file/coc_file.dart';
import 'char_data_part.dart';
part 'info_data.g.dart';

@JsonSerializable()
class InfoData extends CharDataPart {
  COC_File avatar = COC_File.Asset( url:'assets/images/user_avatar.png');
  String name = "";
  String era = "";
  int age = 0;
  String sex = "";
  String residence = "";
  String birthplace = "";

  InfoData();

  @override
  bool isFinished() {
    if (name == "" ||
        era == "" ||
        age == 0 ||
        sex == "" ||
        residence == "" ||
        birthplace == "") {
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

  factory InfoData.fromJson(Map<String, dynamic> json) => _$InfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$InfoDataToJson(this);
}