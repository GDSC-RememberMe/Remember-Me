import 'package:dio/dio.dart';
import 'package:remember_me_mobile/common/const/base_urls.dart';
import 'package:remember_me_mobile/common/dio/dio.dart';
import 'package:remember_me_mobile/user/model/body/join_body.dart';
import 'package:remember_me_mobile/user/model/body/login_body.dart';
import 'package:remember_me_mobile/user/model/body/validation_body.dart';
import 'package:remember_me_mobile/user/model/response/token_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(
  keepAlive: true,
)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: AUTH_BASE_URL, dio: dio);
}

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository({required this.baseUrl, required this.dio});

  Future<TokenResponse?> join({
    required JoinBody body,
  }) async {
    final resp = await dio.post(
      "$baseUrl/join",
      data: body.toJson(),
    );

    return TokenResponse.fromJson(resp.data);
  }

  Future<TokenResponse> login({
    required String username,
    required String password,
  }) async {
    final resp = await dio.post(
      "$baseUrl/login",
      data: {
        LoginBody(
          username: username,
          password: password,
        ).toJson(),
      },
    );

    return TokenResponse.fromJson(resp.data);
  }

  Future<bool> joinValidation({
    required ValidationBody body,
    required String path,
  }) async {
    try {
      final resp = await dio.post(
        "$VALIDATION_BASE_URL/$path",
        data: body.toJson(),
      );

      return resp.statusCode == 200;
    } on DioError catch (_) {
      return false;
    }
  }
}
