// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nostalgia_calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NostalgiaCalendarModel _$NostalgiaCalendarModelFromJson(
        Map<String, dynamic> json) =>
    NostalgiaCalendarModel(
      nostalgiaResults: (json[''] as List<dynamic>)
          .map((e) => NostalgiaResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      when: DateTime.parse(json['when'] as String),
    );

Map<String, dynamic> _$NostalgiaCalendarModelToJson(
        NostalgiaCalendarModel instance) =>
    <String, dynamic>{
      '': instance.nostalgiaResults,
      'when': instance.when.toIso8601String(),
    };
