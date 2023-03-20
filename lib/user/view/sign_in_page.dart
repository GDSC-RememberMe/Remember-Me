import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/common/component/contained_button.dart';
import 'package:remember_me_mobile/common/component/remember_me_logo.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';
import 'package:remember_me_mobile/common/view/caregiver_main_tab_page.dart';
import 'package:remember_me_mobile/common/view/patient_main_tab_page.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
import 'package:remember_me_mobile/user/provider/current_user_provider.dart';
import 'package:remember_me_mobile/user/view/sign_up_page.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  static String get routeName => "signin";

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RememberMeLayout(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 47.5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RememberMeLogo(),
                SizedBox(height: 33.0.h),
                SignInTextFormField(
                  ctrl: idCtrl,
                  hintText: "아이디",
                ),
                SizedBox(height: 10.0.h),
                SignInTextFormField(
                  ctrl: passwordCtrl,
                  hintText: "비밀번호",
                  obscureText: true,
                ),
                SizedBox(height: 10.0.h),
                ContainedButton(
                  "로그인",
                  onTap: () async {
                    final data = await ref
                        .read(currentUserNotifierProvider.notifier)
                        .login(
                          username: idCtrl.text,
                          password: passwordCtrl.text,
                        );

                    if (data is UserModel) {
                      context.pushNamed(
                          (data as UserModel).role == UserRole.caregiver
                              ? CaregiverMainTabPage.routeName
                              : PatientMainTabPage.routeName);
                    }
                  },
                  buttonColor: Theme.of(context).colorScheme.primary,
                  textColor: WHITE,
                ),
                SizedBox(height: 55.0.h),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      SignUpPage.routeName,
                    );
                  },
                  child: RememberMeText(
                    "회원가입",
                    size: 12.0.sp,
                    color: const Color(0xFF6F6F6F),
                    letterSpacing: -0.6.sp,
                    weight: REGULAR,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInTextFormField extends StatelessWidget {
  SignInTextFormField({
    super.key,
    required this.ctrl,
    required this.hintText,
    this.constraints,
    this.obscureText = false,
    this.onChanged,
  });

  final TextEditingController ctrl;
  final String hintText;
  final BoxConstraints? constraints;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  final TextStyle baseStyle = TextStyle(
    fontSize: 12.0.sp,
    fontWeight: MEDIUM,
    color: const Color(0xFFA2A2A2),
    letterSpacing: -0.6.sp,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: ctrl,
      style: baseStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.0.h,
          horizontal: 17.0.w,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5.w,
            color: const Color(
              0xFF707070,
            ),
          ),
          borderRadius: BorderRadius.circular(22).r,
        ),
        hintText: hintText,
        hintStyle: baseStyle,
        constraints: constraints,
      ),
    );
  }
}
