import 'package:json_annotation/json_annotation.dart';
import 'package:remember_me_mobile/common/utils/data_utils.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_item_model.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_result_model.dart';

part "nostalgia_calendar_model.g.dart";

@JsonSerializable()
class NostalgiaCalendarModel {
  @JsonKey(name: "")
  final List<NostalgiaResultModel> nostalgiaResults;
  final DateTime when;

  NostalgiaCalendarModel({
    required this.nostalgiaResults,
    required this.when,
  });

  factory NostalgiaCalendarModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NostalgiaCalendarModelFromJson(json);

  Map<String, dynamic> toJson() => _$NostalgiaCalendarModelToJson(this);
}
