// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      phone: json['phone'] as String,
      username: json['username'] as String,
      nickname: json['nickname'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      profileImg: json['profileImg'] as String?,
      birth: DataUtils.stringToDateTime(json['birth'] as String?),
      address: json['address'] as String?,
      pushCnt: json['pushCnt'] as int,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'phone': instance.phone,
      'username': instance.username,
      'nickname': instance.nickname,
      'role': _$UserRoleEnumMap[instance.role]!,
      'profileImg': instance.profileImg,
      'birth': instance.birth.toIso8601String(),
      'address': instance.address,
      'pushCnt': instance.pushCnt,
    };

const _$UserRoleEnumMap = {
  UserRole.patient: 'PATIENT',
  UserRole.caregiver: 'CAREGIVER',
};
