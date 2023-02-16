import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:remember_me_mobile/common/const/base_urls.dart';
import 'package:remember_me_mobile/common/const/data.dart';
import 'package:remember_me_mobile/common/secure_storage/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@Riverpod(
  keepAlive: true,
)
Dio dio(DioRef ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(storage: storage, ref: ref),
  );

  return dio;
}

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({required this.storage, required this.ref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["accessToken"] == "true") {
      options.headers.remove("accessToken");
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'Authorization': token,
      });
    }

    if (options.headers["refreshToken"] == "true") {
      options.headers.remove("refreshToken");
      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'Authorization': token,
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  // TODO onError 만들기

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == "/auth/reissue";

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post(
          "$AUTH_BASE_URL/reissue",
          options: Options(
            headers: {
              "Authorization": refreshToken,
            },
          ),
        );

        final accessToken = resp.data["access_token"];
        final options = err.requestOptions;

        options.headers.addAll({
          "Authorization": accessToken,
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioError catch (e) {
        // TODO 로그아웃
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
