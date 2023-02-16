import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:remember_me_mobile/common/const/data.dart';
import 'package:remember_me_mobile/common/secure_storage/secure_storage.dart';
import 'package:remember_me_mobile/user/model/body/join_body.dart';
import 'package:remember_me_mobile/user/model/body/update_profile_body.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
import 'package:remember_me_mobile/user/repository/auth_repository.dart';
import 'package:remember_me_mobile/user/repository/user_repository.dart';

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

    final getInfoResp = await repository.getUserInfo();

    final resp = getInfoResp;

    state = resp;
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
  }) async {
    try {
      state = UserModelLoading();

      final JoinBody joinBody = JoinBody(
        username: username,
        password: password,
        phone: phone,
        nickname: nickname,
        role: role,
        birth: birth,
      );

      final resp = await authRepository.join(
        body: joinBody,
      );
    } catch (e) {
      state = UserModelError(message: "회원 가입에 실패했습니다.");

      return Future.value(state);
    }
  }

  // TODO join

  // TODO logout

  // TODO updateUser

  Future<void> updateUserProfile({
    String? phone,
    String? nickname,
  }) async {
    try {
      await repository.updateUserProfile(
        body: UpdateProfileBody(phone: phone, nickname: nickname),
      );
    } catch (e) {}
  }

  // TODO Image UPDATE
}
