import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/user/provider/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router.g.dart';

@Riverpod(
  keepAlive: true,
)
GoRouter router(RouterRef ref) {
  final provider = ref.read(authProvider);
  return GoRouter(
    routes: provider.routes,
    initialLocation: "/signin",
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
}
