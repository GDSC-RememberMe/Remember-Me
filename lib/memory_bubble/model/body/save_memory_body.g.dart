// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_memory_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveMemoryBody _$SaveMemoryBodyFromJson(Map<String, dynamic> json) =>
    SaveMemoryBody(
      title: json['title'] as String,
      content: json['content'] as String,
      tagWho: json['tagWho'] as String,
      tagWhere: json['tagWhere'] as String,
      tagWhat: json['tagWhat'] as String,
    );

Map<String, dynamic> _$SaveMemoryBodyToJson(SaveMemoryBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'tagWho': instance.tagWho,
      'tagWhere': instance.tagWhere,
      'tagWhat': instance.tagWhat,
    };
