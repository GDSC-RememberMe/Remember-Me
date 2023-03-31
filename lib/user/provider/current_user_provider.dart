import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:remember_me_mobile/common/const/data.dart';
import 'package:remember_me_mobile/common/secure_storage/secure_storage.dart';
import 'package:remember_me_mobile/user/model/body/join_body.dart';
import 'package:remember_me_mobile/user/model/body/update_profile_body.dart';
import 'package:remember_me_mobile/user/model/body/validation_body.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
import 'package:remember_me_mobile/user/repository/auth_repository.dart';
import 'package:remember_me_mobile/user/repository/user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final currentUserNotifierProvider = StateNotifierProvider<CurrentUserStateNotifier, UserModelBase?>((ref) {
  final authorizationRepository = ref.watch(authRepositoryProvider);
  final currentUserNotifierRepository = ref.watch(userRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return CurrentUserStateNotifier(
    authRepository: authorizationRepository,
    repository: currentUserNotifierRepository,
    storage: storage,
  );
});

class CurrentUserStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserRepository repository;
  final FlutterSecureStorage storage;

  CurrentUserStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    getCurrentUserInfo();
  }

  Future<void> getCurrentUserInfo() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    try {
      final getInfoResp = await repository.getUserInfo();

      final resp = getInfoResp;
      state = resp;
    } catch (e) {
      state = UserModelError(message: "유저를 불러올 수 없습니다.");
    }
  }

  Future<UserModelBase?> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(username: username, password: password);

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      final userInfoResp = await repository.getUserInfo();

      state = userInfoResp;

      return userInfoResp;
    } catch (e) {
      state = UserModelError(message: "로그인에 실패했습니다.");

      return Future.value(state);
    }
  }

  Future<UserModelBase?> join({
    required String username,
    required String password,
    required String phone,
    required String nickname,
    required UserRole role,
    required DateTime birth,
    required String gender,
    required File profileImg,
    required String address,
  }) async {
    try {
      state = UserModelLoading();

      FirebaseMessaging.instance.getToken().then((token) async {
        final JoinBody joinBody = JoinBody(
          username: username,
          password: password,
          phone: phone,
          nickname: nickname,
          role: role,
          birth: DateFormat('yyyy-MM-dd').format(birth),
          gender: gender == "남성" ? "MALE" : "FEMALE",
          address: address,
          fcmToken: "$token",
        );

        final resp = await authRepository.join(
          body: joinBody,
        );

        if (resp != null) {
          await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
          await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
          await repository.updateImage(image: profileImg);
          final userInfoResp = await repository.getUserInfo();

          state = userInfoResp;

          return userInfoResp;
        }
      });
    } catch (e) {
      state = UserModelError(message: "회원 가입에 실패했습니다.");

      return Future.value(state);
    }
  }

  // TODO logout
  Future<void> logout() async {
    state = null;

    await Future.wait(
      [
        storage.delete(key: REFRESH_TOKEN_KEY),
        storage.delete(key: ACCESS_TOKEN_KEY),
      ],
    );
  }

  // TODO updateUser
  Future<void> updateUserProfile({
    String? phone,
    String? nickname,
  }) async {
    try {
      await repository.updateUserProfile(
        body: UpdateProfileBody(phone: phone, nickname: nickname),
      );

      await getCurrentUserInfo();
    } catch (e) {}
  }

  // TODO Image UPDATE

  Future<void> updateImage({
    required XFile image,
  }) async {
    try {
      await repository.updateImage(
        image: File(image.path),
      );

      await getCurrentUserInfo();
    } catch (e) {}
  }

  // TODO validation
  Future<bool> joinValidation({
    String? username,
    String? phone,
    required String path,
  }) async {
    final ValidationBody body = ValidationBody(
      username: username,
      phone: phone,
    );

    final resp = await authRepository.joinValidation(
      body: body,
      path: path,
    );

    return resp;
  }
}
