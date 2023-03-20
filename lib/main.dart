import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/provider/go_router.dart';
import 'package:remember_me_mobile/common/utils/data_utils.dart';
import 'package:remember_me_mobile/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: "Remember Me",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: DataUtils.createMaterialColor(PRIMARY_COLOR),
              backgroundColor: WHITE,
            ).copyWith(
              primary: PRIMARY_COLOR,
            ),
            fontFamily: NOTO_SANS,
            dialogBackgroundColor: WHITE,
            scaffoldBackgroundColor: WHITE,
          ),
          darkTheme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: DataUtils.createMaterialColor(PRIMARY_COLOR),
              backgroundColor: WHITE,
            ).copyWith(
              primary: PRIMARY_COLOR,
            ),
            fontFamily: NOTO_SANS,
            dialogBackgroundColor: WHITE,
            scaffoldBackgroundColor: WHITE,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', 'KR'),
          ],
          locale: const Locale('ko'),
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
        );
      },
    );
  }
}
