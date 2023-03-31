import 'package:json_annotation/json_annotation.dart';

part "update_memory_body.g.dart";

@JsonSerializable()
class UpdateMemoryBody {
  final String? title;
  final String? content;
  final String? tagWho;
  final String? tagWhere;
  final String? tagWhat;

  UpdateMemoryBody({
    required this.title,
    required this.content,
    required this.tagWho,
    required this.tagWhere,
    required this.tagWhat,
  });

  factory UpdateMemoryBody.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UpdateMemoryBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMemoryBodyToJson(this);
}
