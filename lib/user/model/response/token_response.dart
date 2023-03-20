import 'package:json_annotation/json_annotation.dart';

part "token_response.g.dart";

@JsonSerializable()
class TokenResponse {
  final String refreshToken;
  final String accessToken;

  TokenResponse({
    required this.refreshToken,
    required this.accessToken,
  });

  factory TokenResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TokenResponseFromJson(json);
}
