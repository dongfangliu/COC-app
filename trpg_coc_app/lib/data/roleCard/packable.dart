
import 'package:json_annotation/json_annotation.dart';
part 'packable.g.dart';
@JsonSerializable()
class packable{
  String name="undefined";
  String description="undefined";
  int num=-1;
  String loc="undefined";

  factory packable.fromJson(Map<String, dynamic> json) =>
      _$packableFromJson(json);

  Map<String, dynamic> toJson() => _$packableToJson(this);

  packable();
}