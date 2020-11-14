// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommentLikes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment<CoommentSource, ContentType, CommentTarget>
    _$CommentFromJson<CoommentSource, ContentType, CommentTarget>(
        Map<String, dynamic> json) {
  return Comment<CoommentSource, ContentType, CommentTarget>()
    ..from = _dataFromJson(json['from'] as Map<String, dynamic>)
    ..content = _dataFromJson(json['content'] as Map<String, dynamic>)
    ..target = _dataFromJson(json['target'] as Map<String, dynamic>);
}

Map<String, dynamic>
    _$CommentToJson<CoommentSource, ContentType, CommentTarget>(
            Comment<CoommentSource, ContentType, CommentTarget> instance) =>
        <String, dynamic>{
          'from': _dataToJson(instance.from),
          'content': _dataToJson(instance.content),
          'target': _dataToJson(instance.target),
        };

StrComment<CoommentSource, CommentTarget>
    _$StrCommentFromJson<CoommentSource, CommentTarget>(
        Map<String, dynamic> json) {
  return StrComment<CoommentSource, CommentTarget>()
    ..from = _dataFromJson(json['from'] as Map<String, dynamic>)
    ..content = _dataFromJson(json['content'] as Map<String, dynamic>)
    ..target = _dataFromJson(json['target'] as Map<String, dynamic>);
}

Map<String, dynamic> _$StrCommentToJson<CoommentSource, CommentTarget>(
        StrComment<CoommentSource, CommentTarget> instance) =>
    <String, dynamic>{
      'from': _dataToJson(instance.from),
      'content': _dataToJson(instance.content),
      'target': _dataToJson(instance.target),
    };

Like<LikeSource, LikeTarget> _$LikeFromJson<LikeSource, LikeTarget>(
    Map<String, dynamic> json) {
  return Like<LikeSource, LikeTarget>()
    ..from = _dataFromJson(json['from'] as Map<String, dynamic>)
    ..target = _dataFromJson(json['target'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LikeToJson<LikeSource, LikeTarget>(
        Like<LikeSource, LikeTarget> instance) =>
    <String, dynamic>{
      'from': _dataToJson(instance.from),
      'target': _dataToJson(instance.target),
    };

BmobLike _$BmobLikeFromJson(Map<String, dynamic> json) {
  return BmobLike()
    ..from = _dataFromJson(json['from'] as Map<String, dynamic>)
    ..target = _dataFromJson(json['target'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BmobLikeToJson(BmobLike instance) => <String, dynamic>{
      'from': _dataToJson(instance.from),
      'target': _dataToJson(instance.target),
    };

BmobStrComment _$BmobStrCommentFromJson(Map<String, dynamic> json) {
  return BmobStrComment()
    ..from = _dataFromJson(json['from'] as Map<String, dynamic>)
    ..content = _dataFromJson(json['content'] as Map<String, dynamic>)
    ..target = _dataFromJson(json['target'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BmobStrCommentToJson(BmobStrComment instance) =>
    <String, dynamic>{
      'from': _dataToJson(instance.from),
      'content': _dataToJson(instance.content),
      'target': _dataToJson(instance.target),
    };
