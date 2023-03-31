import 'package:json_annotation/json_annotation.dart';

part "nostalgia_item_model.g.dart";

@JsonSerializable()
class NostalgiaItemModel {
  final int? rightNostalgiaItemId;
  final String imgUrl;
  final String rightAnswer;
  final String wrongAnswer;

  NostalgiaItemModel({
    required this.rightNostalgiaItemId,
    required this.imgUrl,
    required this.rightAnswer,
    required this.wrongAnswer,
  });

  factory NostalgiaItemModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NostalgiaItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$NostalgiaItemModelToJson(this);
}
