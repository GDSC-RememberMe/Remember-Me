import 'package:json_annotation/json_annotation.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';

part "update_profile_body.g.dart";

@JsonSerializable()
class UpdateProfileBody {
  final String? phone;
  final String? nickname;

  UpdateProfileBody({
    required this.phone,
    required this.nickname,
  });

  factory UpdateProfileBody.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UpdateProfileBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileBodyToJson(this);
}
