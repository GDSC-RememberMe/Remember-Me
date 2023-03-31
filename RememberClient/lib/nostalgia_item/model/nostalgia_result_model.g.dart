// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nostalgia_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NostalgiaResultModel _$NostalgiaResultModelFromJson(
        Map<String, dynamic> json) =>
    NostalgiaResultModel(
      nostalgiaItemId: json['nostalgiaItemId'] as int,
      imgUrl: json['imgUrl'] as String,
      result: json['result'] as bool,
    );

Map<String, dynamic> _$NostalgiaResultModelToJson(
        NostalgiaResultModel instance) =>
    <String, dynamic>{
      'nostalgiaItemId': instance.nostalgiaItemId,
      'imgUrl': instance.imgUrl,
      'result': instance.result,
    };
