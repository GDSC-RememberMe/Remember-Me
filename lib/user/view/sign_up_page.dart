import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/contained_button.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/base_urls.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/fonts.dart';
import 'package:remember_me_mobile/common/dio/dio.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';
import 'package:remember_me_mobile/user/component/sign_up_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController passwordConfirmCtrl = TextEditingController();

  String id = "";
  String password = "";
  String passwordConfirm = "";

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: WHITE,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xFFBABABA),
            width: 0.5.r,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFBABABA),
        ),
        title: RememberMeText(
          "회원가입",
          size: 16.sp,
          letterSpacing: -0.8.sp,
          weight: BOLD,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: RememberMeBox(
            padding: const EdgeInsets.symmetric(
              vertical: 23.0,
              horizontal: 28.0,
            ).r,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SignUpStep(currentIdx: 2),
                        SizedBox(height: 41.r),
                        RememberMeBox(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RememberMeText(
                                "기본 정보를 입력해 주세요.",
                                size: 16.sp,
                                letterSpacing: -0.8.sp,
                                weight: BOLD,
                                color: const Color(0xFF707070),
                              ),
                              SizedBox(height: 23.r),
                              RememberMeText(
                                "아이디",
                                size: 12.sp,
                                letterSpacing: -0.48.sp,
                                weight: BOLD,
                              ),
                              Row(
                                children: [
                                  SignUpTextFormField(
                                    ctrl: idCtrl,
                                    hintText: "아이디를 입력해 주세요.",
                                    constraints: BoxConstraints(maxWidth: 0.45.sw),
                                    onChanged: (String value) {
                                      setState(() {
                                        id = value;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 6.r),
                                  GestureDetector(
                                    onTap: () async {},
                                    child: RememberMeBox(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0).r,
                                      borderColor: const Color(0xFFA5A5A5),
                                      borderWidth: 0.7.r,
                                      borderRadius: BorderRadius.circular(11.0.w),
                                      child: RememberMeText(
                                        "중복확인",
                                        size: 9.sp,
                                        letterSpacing: -0.32.sp,
                                        color: const Color(0xFFA5A5A5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.r),
                              RememberMeText(
                                "비밀번호",
                                size: 12.sp,
                                letterSpacing: -0.48.sp,
                                weight: BOLD,
                              ),
                              SignUpTextFormField(
                                ctrl: passwordCtrl,
                                hintText: "비밀번호를 입력해 주세요.",
                                obscureText: true,
                                onChanged: (String value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                              SignUpTextFormField(
                                ctrl: passwordConfirmCtrl,
                                hintText: "비밀번호를 다시 입력해 주세요.",
                                obscureText: true,
                                onChanged: (String value) {
                                  setState(() {
                                    passwordConfirm = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ContainedButton(
                  "다음 단계",
                  onTap: () async {},
                  buttonColor: id.isNotEmpty && password.isNotEmpty && passwordConfirm.isNotEmpty
                      ? Theme.of(context).colorScheme.primary
                      : const Color(0xFFA5A5A5),
                  textColor: WHITE,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpStep extends StatelessWidget {
  const _SignUpStep({
    super.key,
    required this.currentIdx,
  });

  final int currentIdx;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _progressBar(),
        Align(
          alignment: Alignment.centerLeft,
          child: UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: RememberMeBox(
              borderRadius: BorderRadius.circular(13.0).w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _progressCircle(context: context, progressIdx: 1),
                  _progressCircle(context: context, progressIdx: 2),
                  _progressCircle(context: context, progressIdx: 3),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _progressCircle({
    required BuildContext context,
    required int progressIdx,
  }) {
    return RememberMeBox(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 12.0,
      ).r,
      shape: BoxShape.circle,
      color: progressIdx == currentIdx ? Theme.of(context).colorScheme.primary : Colors.transparent,
      child: RememberMeText(
        progressIdx.toString(),
        size: 16.sp,
        letterSpacing: -0.8.sp,
        weight: BOLD,
        color: progressIdx == currentIdx ? WHITE : const Color(0xFF707070),
      ),
    );
  }

  Widget _progressBar() {
    return UnconstrainedBox(
      alignment: Alignment.centerLeft,
      child: RememberMeBox(
        margin: const EdgeInsets.symmetric(vertical: 3.0).r,
        color: const Color(0xFFBABABA).withOpacity(0.25),
        padding: const EdgeInsets.symmetric(vertical: 3.0).r,
        borderRadius: BorderRadius.circular(13.0).w,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RememberMeBox(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ).r,
              child: RememberMeText(
                "1",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
            RememberMeBox(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ).r,
              child: RememberMeText(
                "2",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
            RememberMeBox(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ).r,
              child: RememberMeText(
                "3",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
