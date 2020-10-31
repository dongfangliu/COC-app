//part of 'char_data_part.dart';
import 'char_data_part.dart';

import 'package:json_annotation/json_annotation.dart';

part 'invt_data.g.dart';

@JsonSerializable()
class InvtData extends CharDataPart {
  // 自动生成
  String livingStd = "";      // 生活水平
  double cash = 0;            // 现金
  int otherAsset = 0;         // 其他资产
  double consumptionStd = 0;  // 消费水平

  // 需要在 invt 页中填写
  String assetDesc = "";    // 请在此详述您的资产
  List<String> invts = [];  // 装备和随身物品

  InvtData();

  bool isFinished() {
    if ( assetDesc == "" || invts == [] ) { return false; }
    else { return true; }
  }

  @override
  Map getParams() {
    // TODO: implement getParams
    throw UnimplementedError();
  }

  factory InvtData.fromJson(Map<String, dynamic> json) => _$InvtDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvtDataToJson(this);
}