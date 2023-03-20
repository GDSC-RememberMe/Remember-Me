// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_memory_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMemoryBody _$UpdateMemoryBodyFromJson(Map<String, dynamic> json) =>
    UpdateMemoryBody(
      title: json['title'] as String?,
      content: json['content'] as String?,
      tagWho: json['tagWho'] as String?,
      tagWhere: json['tagWhere'] as String?,
      tagWhat: json['tagWhat'] as String?,
    );

Map<String, dynamic> _$UpdateMemoryBodyToJson(UpdateMemoryBody instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'tagWho': instance.tagWho,
      'tagWhere': instance.tagWhere,
      'tagWhat': instance.tagWhat,
    };
