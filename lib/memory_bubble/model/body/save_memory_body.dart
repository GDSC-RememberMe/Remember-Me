import 'package:json_annotation/json_annotation.dart';

part "save_memory_body.g.dart";

@JsonSerializable()
class SaveMemoryBody {
  final String title;
  final String content;
  final String tagWho;
  final String tagWhere;
  final String tagWhat;

  SaveMemoryBody({
    required this.title,
    required this.content,
    required this.tagWho,
    required this.tagWhere,
    required this.tagWhat,
  });

  factory SaveMemoryBody.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SaveMemoryBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SaveMemoryBodyToJson(this);
}
