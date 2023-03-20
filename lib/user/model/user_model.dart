import 'package:json_annotation/json_annotation.dart';
import 'package:remember_me_mobile/common/utils/data_utils.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({required this.message});
}

class UserModelLoading extends UserModelBase {}

enum UserRole {
  @JsonValue("PATIENT")
  patient,
  @JsonValue("CAREGIVER")
  caregiver,
}

@JsonSerializable()
class UserModel extends UserModelBase {
  final String phone;
  final String username;
  final String? nickname;
  final UserRole role;
  final String? profileImg;
  @JsonKey(
    fromJson: DataUtils.stringToDateTime,
  )
  final DateTime birth;
  final String? address;
  final int pushCnt;
  final String gender;

  UserModel({
    required this.phone,
    required this.username,
    required this.nickname,
    required this.role,
    required this.profileImg,
    required this.birth,
    required this.address,
    required this.pushCnt,
    required this.gender,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
