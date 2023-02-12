import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/fonts.dart';
import 'package:remember_me_mobile/common/utils/data_utils.dart';
import 'package:remember_me_mobile/common/view/onboarding_page.dart';
import 'package:remember_me_mobile/user/view/sign_up_page.dart';

void main() {
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
    return ScreenUtilInit(
      designSize: const Size(375, 768),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
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
          home: SignUpPage(),
        );
      },
    );
  }
}
