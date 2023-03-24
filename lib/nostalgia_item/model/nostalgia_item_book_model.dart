import 'package:json_annotation/json_annotation.dart';

part "nostalgia_item_book_model.g.dart";

@JsonSerializable()
class NostalgiaItemBookModel {
  final int? id;
  final String imgUrl;

  NostalgiaItemBookModel({
    required this.id,
    required this.imgUrl,
  });

  factory NostalgiaItemBookModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NostalgiaItemBookModelFromJson(json);

  Map<String, dynamic> toJson() => _$NostalgiaItemBookModelToJson(this);
}
