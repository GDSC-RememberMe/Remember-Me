import 'package:json_annotation/json_annotation.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';

part "validation_body.g.dart";

@JsonSerializable()
class ValidationBody {
  final String? username;
  final String? phone;

  ValidationBody({
    required this.username,
    required this.phone,
  });

  factory ValidationBody.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ValidationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationBodyToJson(this);
}
