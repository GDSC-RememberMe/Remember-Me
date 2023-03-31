// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nostalgia_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NostalgiaItemModel _$NostalgiaItemModelFromJson(Map<String, dynamic> json) =>
    NostalgiaItemModel(
      rightNostalgiaItemId: json['rightNostalgiaItemId'] as int?,
      imgUrl: json['imgUrl'] as String,
      rightAnswer: json['rightAnswer'] as String,
      wrongAnswer: json['wrongAnswer'] as String,
    );

Map<String, dynamic> _$NostalgiaItemModelToJson(NostalgiaItemModel instance) =>
    <String, dynamic>{
      'rightNostalgiaItemId': instance.rightNostalgiaItemId,
      'imgUrl': instance.imgUrl,
      'rightAnswer': instance.rightAnswer,
      'wrongAnswer': instance.wrongAnswer,
    };
