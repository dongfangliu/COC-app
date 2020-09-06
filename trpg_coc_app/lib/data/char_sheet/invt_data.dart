//part of 'char_data_part.dart';
import 'char_data_part.dart';

import 'package:json_annotation/json_annotation.dart';

part 'invt_data.g.dart';

@JsonSerializable()
class InvtData extends CharDataPart {
  double cash;

  InvtData();

  bool isFinished() {
    return true;
    if (
    cash == null
    ) {
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

  factory InvtData.fromJson(Map<String, dynamic> json) => _$InvtDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvtDataToJson(this);
}