import 'package:json_annotation/json_annotation.dart';

part "memory_model.g.dart";

@JsonSerializable()
class MemoryModel {
  final int? memoryId;
  final String? title;
  final String? content;
  final String? tagWho;
  final String? tagWhere;
  final String? tagWhat;
  final String? imgUrl;
  final String? audioUrl;

  MemoryModel({
    required this.memoryId,
    required this.title,
    required this.content,
    required this.tagWho,
    required this.tagWhere,
    required this.tagWhat,
    required this.imgUrl,
    required this.audioUrl,
  });

  factory MemoryModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MemoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemoryModelToJson(this);

  MemoryModel copyWith({
    int? memoryId,
    String? title,
    String? content,
    String? tagWho,
    String? tagWhere,
    String? tagWhat,
    String? imgUrl,
    String? audioUrl,
  }) {
    return MemoryModel(
      memoryId: memoryId ?? this.memoryId,
      title: title ?? this.title,
      content: content ?? this.content,
      tagWho: tagWho ?? this.tagWho,
      tagWhere: tagWhere ?? this.tagWhere,
      tagWhat: tagWhat ?? this.tagWhat,
      imgUrl: imgUrl ?? this.imgUrl,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }
}
