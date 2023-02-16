// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinBody _$JoinBodyFromJson(Map<String, dynamic> json) => JoinBody(
      username: json['username'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      nickname: json['nickname'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      birth: DateTime.parse(json['birth'] as String),
    );

Map<String, dynamic> _$JoinBodyToJson(JoinBody instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'phone': instance.phone,
      'nickname': instance.nickname,
      'role': _$UserRoleEnumMap[instance.role]!,
      'birth': instance.birth.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.patient: 'PATIENT',
  UserRole.caregiver: 'CAREGIVER',
};
