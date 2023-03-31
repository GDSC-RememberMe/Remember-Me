import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:remember_me_mobile/common/const/base_urls.dart';
import 'package:remember_me_mobile/common/dio/dio.dart';
import 'package:remember_me_mobile/user/model/body/update_profile_body.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@Riverpod(
  keepAlive: true,
)
UserRepository userRepository(UserRepositoryRef ref) {
  final dio = ref.watch(dioProvider);

  return UserRepository(dio, baseUrl: USER_BASE_URL);
}

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET("/info")
  @Headers({
    "accessToken": "true",
  })
  Future<UserModel> getUserInfo();

  @PATCH("/update")
  @Headers({
    "accessToken": "true",
  })
  Future<UserModel> updateUserProfile({
    @Body() required UpdateProfileBody body,
  });

  // TODO Image Update

  @POST("/profile")
  @Headers({
    "accessToken": "true",
  })
  Future<void> updateImage({
    @Part(name: "file") required File image,
  });
}
