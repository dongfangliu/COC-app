import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CommentLikes.g.dart';

T _dataFromJson<T>(Map<String, dynamic> input) => input['value'] as T;

Map<String, dynamic> _dataToJson<T>(T input) => {'value': input};

@JsonSerializable(createFactory:true)
class Comment<CoommentSource,ContentType,CommentTarget>{

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  CoommentSource from;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  ContentType content;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  CommentTarget target;
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);


  Comment({this.from, this.content, this.target});
}

@JsonSerializable(createFactory:true)
class StrComment<CoommentSource,CommentTarget> extends Comment<CoommentSource,String,CommentTarget>{
  factory StrComment.fromJson(Map<String, dynamic> json) =>
      _$StrCommentFromJson(json);

  StrComment({CoommentSource src,String comment,CommentTarget target}):super(from:src,content:comment,target:target);
}
@JsonSerializable(createFactory:true)
class Like<LikeSource,LikeTarget>{

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  LikeSource from;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  LikeTarget target;
  factory Like.fromJson(Map<String, dynamic> json) =>
      _$LikeFromJson(json);


  Like({this.from, this.target});
}

@JsonSerializable(createFactory:true)
class BmobLike extends Like<BmobObject,BmobObject>{
  factory BmobLike.fromJson(Map<String, dynamic> json) =>
      _$BmobLikeFromJson(json);

  BmobLike({BmobObject from ,BmobObject target}):super(from:from,target:target);
}
@JsonSerializable(createFactory:true)
class BmobStrComment extends StrComment<BmobObject,BmobObject>{
  factory BmobStrComment.fromJson(Map<String, dynamic> json) =>
      _$BmobStrCommentFromJson(json);

  BmobStrComment({BmobObject from,String comment,BmobObject target}):super(src:from,comment:comment,target:target);
}