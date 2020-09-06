//part of 'char_data_part.dart';
import 'char_data_part.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/occupations.dart';

import 'package:json_annotation/json_annotation.dart';

part 'occu_data.g.dart';

@JsonSerializable()
class OccuData extends CharDataPart {
  Occu occu;

  OccuData();

  @override
  bool isFinished() {
    if (occu == null) { return false; }
    else { return true; }
  }

  @override
  Map getParams() {
    // TODO: implement getParams
    throw UnimplementedError();
  }

  factory OccuData.fromJson(Map<String, dynamic> json) => _$OccuDataFromJson(json);

  Map<String, dynamic> toJson() => _$OccuDataToJson(this);
}
