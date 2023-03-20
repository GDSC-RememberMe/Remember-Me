import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember_me_mobile/common/view/caregiver_main_tab_page.dart';
import 'package:remember_me_mobile/common/view/patient_main_tab_page.dart';
import 'package:remember_me_mobile/common/view/splash_page.dart';
import 'package:remember_me_mobile/memory_bubble/view/memory_bubble_detail_page.dart';
import 'package:remember_me_mobile/memory_bubble/view/memory_edit_form_page.dart';
import 'package:remember_me_mobile/memory_check/view/patient_memory_check_page.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
import 'package:remember_me_mobile/user/provider/current_user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/user/view/sign_in_page.dart';
import 'package:remember_me_mobile/user/view/sign_up_page.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(currentUserNotifierProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: "/splash",
          name: SplashPage.routeName,
          builder: (_, __) => const SplashPage(),
        ),
        GoRoute(
          path: "/signin",
          name: SignInPage.routeName,
          builder: (_, __) => const SignInPage(),
        ),
        GoRoute(
          path: "/signup",
          name: SignUpPage.routeName,
          builder: (_, __) => const SignUpPage(),
        ),
        GoRoute(
          path: "/patient_main_tab",
          name: PatientMainTabPage.routeName,
          builder: (_, __) => const PatientMainTabPage(),
        ),
        GoRoute(
          path: "/caregiver_main_tab",
          name: CaregiverMainTabPage.routeName,
          builder: (_, __) => const CaregiverMainTabPage(),
        ),
        GoRoute(
          path: "/memory_bubble_detail/:imgUrl/:isFromPatient",
          name: MemoryBubbleDetailPage.routeName,
          builder: (context, state) => MemoryBubbleDetailPage(
            imgUrl: "${state.params["imgUrl"]}",
            isFromPatient: state.params["isFromPatient"] == "true",
          ),
        ),
        GoRoute(
          path: "/patient_memory_check",
          name: PatientMemoryCheckPage.routeName,
          builder: (context, state) => const PatientMemoryCheckPage(),
        ),
        GoRoute(
          path: "/memory_edit_form",
          name: MemoryEditFormPage.routeName,
          builder: (_, __) => const MemoryEditFormPage(),
        )
      ];

  // TODO Routes

  // TODO Logout

  String? redirectLogic(BuildContext context, GoRouterState state) {
    // TODO redirectLogic

    return null;
  }
}
