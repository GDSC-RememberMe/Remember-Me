// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoryModel _$MemoryModelFromJson(Map<String, dynamic> json) => MemoryModel(
      memoryId: json['memoryId'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      tagWho: json['tagWho'] as String?,
      tagWhere: json['tagWhere'] as String?,
      tagWhat: json['tagWhat'] as String?,
      imgUrl: json['imgUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
    );

Map<String, dynamic> _$MemoryModelToJson(MemoryModel instance) =>
    <String, dynamic>{
      'memoryId': instance.memoryId,
      'title': instance.title,
      'content': instance.content,
      'tagWho': instance.tagWho,
      'tagWhere': instance.tagWhere,
      'tagWhat': instance.tagWhat,
      'imgUrl': instance.imgUrl,
      'audioUrl': instance.audioUrl,
    };
