import 'package:json_annotation/json_annotation.dart';
import 'package:remember_me_mobile/common/utils/data_utils.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_item_model.dart';

part "nostalgia_result_model.g.dart";

@JsonSerializable()
class NostalgiaResultModel {
  final int nostalgiaItemId;
  final String imgUrl;
  final bool result;

  NostalgiaResultModel({
    required this.nostalgiaItemId,
    required this.imgUrl,
    required this.result,
  });

  factory NostalgiaResultModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NostalgiaResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$NostalgiaResultModelToJson(this);
}
