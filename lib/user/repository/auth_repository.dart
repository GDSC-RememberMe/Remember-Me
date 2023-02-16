import 'package:dio/dio.dart';
import 'package:remember_me_mobile/common/const/base_urls.dart';
import 'package:remember_me_mobile/common/dio/dio.dart';
import 'package:remember_me_mobile/user/model/body/join_body.dart';
import 'package:remember_me_mobile/user/model/body/login_body.dart';
import 'package:remember_me_mobile/user/model/body/validation_body.dart';
import 'package:remember_me_mobile/user/model/response/login_response.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
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

  Future<bool> join({
    required JoinBody body,
  }) async {
    try {
      final resp = await dio.post(
        "$baseUrl/join",
        data: {
          body.toJson(),
        },
      );

      return resp.data != null;
    } catch (e) {
      return false;
    }
  }

  Future<LoginResponse> login({
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

    return LoginResponse.fromJson(resp.data);
  }

  Future<bool> usernameValidation({
    required ValidationBody body,
  }) async {
    try {
      final resp = await dio.post(
        "$VALIDATION_BASE_URL/username",
        data: body.toJson(),
      );

      return resp.statusCode == 200;
    } on DioError catch (_) {
      return false;
    }
  }

  Future<bool> phoneValidation({
    required ValidationBody body,
  }) async {
    try {
      final resp = await dio.post(
        "$VALIDATION_BASE_URL/phone",
        data: body.toJson(),
      );

      return resp.statusCode == 200;
    } on DioError catch (_) {
      return false;
    }
  }
}
