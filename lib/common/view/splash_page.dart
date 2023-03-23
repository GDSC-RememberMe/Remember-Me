import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_logo.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static String get routeName => "splash";

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SizedBox(
        width: 1.0.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/purple_final.png", width: 0.5.sw),
            const RememberMeLogo(
              color: WHITE,
            ),
          ],
        ),
      ),
    );
  }
}
