import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 47.5).r,
        children: [
          TextFormField(),
        ],
      ),
    );
  }
}
