import 'package:json_annotation/json_annotation.dart';

part 'term_model.g.dart';

enum TermRole {
  essential,
  optional,
}

@JsonSerializable()
class TermModel {
  final TermRole termRole;
  final String title;
  final bool isAgreed;

  TermModel({
    this.termRole = TermRole.optional,
    required this.title,
    this.isAgreed = false,
  });

  TermModel copyWith({
    required bool? isAgreed,
  }) {
    return TermModel(
      termRole: termRole,
      title: title,
      isAgreed: isAgreed ?? this.isAgreed,
    );
  }
}
