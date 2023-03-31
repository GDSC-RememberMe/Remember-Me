// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'term_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TermModel _$TermModelFromJson(Map<String, dynamic> json) => TermModel(
      termRole: $enumDecodeNullable(_$TermRoleEnumMap, json['termRole']) ??
          TermRole.optional,
      title: json['title'] as String,
      isAgreed: json['isAgreed'] as bool? ?? false,
    );

Map<String, dynamic> _$TermModelToJson(TermModel instance) => <String, dynamic>{
      'termRole': _$TermRoleEnumMap[instance.termRole]!,
      'title': instance.title,
      'isAgreed': instance.isAgreed,
    };

const _$TermRoleEnumMap = {
  TermRole.essential: 'essential',
  TermRole.optional: 'optional',
};
