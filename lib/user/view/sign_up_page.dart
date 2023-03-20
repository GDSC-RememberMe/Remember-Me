import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/common/component/contained_button.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/component/welcome_component.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';
import 'package:remember_me_mobile/common/view/caregiver_main_tab_page.dart';
import 'package:remember_me_mobile/user/component/sign_up_page_views.dart';
import 'package:remember_me_mobile/user/model/term_model.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
import 'package:remember_me_mobile/user/provider/current_user_provider.dart';
import 'package:remember_me_mobile/user/provider/sign_up_provider.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  static String get routeName => "signup";

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final PageController _pageCtrl = PageController(
    initialPage: 0,
  );

  int _currentIdx = 0;

  final List<Widget> _signUpPages = const [
    SignUpFirstPageView(),
    SignUpSecondPageView(),
    SignUpThirdPageView(),
    SignUpFourthPageView(),
    SignUpFifthPageView(),
    SignUpSixthPageView(),
  ];

  bool _visible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _visible
        ? AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 0),
            child: WelcomeComponent(
              text: "환영합니다!\n회원가입이 성공적으로 완료되었어요.",
              widget: RememberMeBox(
                child: Image.asset(
                  "assets/images/hand-with-bangles-showing-all-okay-gesture.png",
                  width: 0.8.sw,
                ),
              ),
            ),
          )
        : RememberMeLayout(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: WHITE,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              shape: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 56, 35, 35),
                  width: 0.5.w,
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
                child: Stack(
                  children: [
                    PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageCtrl,
                      onPageChanged: (idx) {
                        setState(() {
                          _currentIdx = idx;
                        });
                      },
                      itemCount: _signUpPages.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 15.5.h, horizontal: 28.w),
                          child: RememberMeBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SignUpStep(currentIdx: _currentIdx + 1),
                                SizedBox(height: 34.5.h),
                                _signUpPages[index],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: RememberMeBox(
                        margin: EdgeInsets.symmetric(vertical: 15.5.h, horizontal: 28.w),
                        child: ContainedButton(
                          onTap: () => _whenButtonTapped(),
                          buttonColor: const Color(0xFFA5A5A5),
                          textColor: WHITE,
                          "다음 단계",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void _whenButtonTapped() {
    if (_currentIdx < 5) {
      if (getStatusOfCurrentIdxEssentialField()) {
        setState(() {
          _currentIdx = _currentIdx + 1;
        });
        _pageCtrl.animateToPage(_currentIdx, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
      return;
    }

    final signUpData = ref.read(signUpProvider);

    try {
      ref
          .read(currentUserNotifierProvider.notifier)
          .join(
            username: signUpData.idCtrl.text,
            password: signUpData.passwordCtrl.text,
            phone: signUpData.phoneCtrl.text,
            nickname: signUpData.nameCtrl.text,
            role: signUpData.roles.keys.firstWhere((key) => signUpData.roles[key] == true),
            birth: signUpData.birthDate,
            gender: signUpData.gender.keys.firstWhere((key) => signUpData.gender[key] == true),
            address: signUpData.address1Ctrl.text,
            profileImg: File(signUpData.profileImage!.path),
          )
          .then((value) {
        if (value is UserModel) {
          setState(() {
            _visible = true;
          });
          Future.delayed(
            const Duration(milliseconds: 3500),
          ).then((_) {
            context.goNamed(CaregiverMainTabPage.routeName);
          });
        }
        print(value);
      });
    } catch (e) {
      print(e.toString());
    }

    // TODO 가입 완료 router redirect 설정
    // TODO 가입 완료 후 환자 or 보호자에 따라 다른 페이지로 이동
    // TODO 가입 완료 api 붙이기
    // TODO 항목 채워야 넘어갈 수 있도록 설정
  }

  bool getStatusOfCurrentIdxEssentialField() {
    final signUpData = ref.read(signUpProvider);
    bool status = false;
    switch (_currentIdx) {
      case 0:
        status = signUpData.roles.containsValue(true);
        return status;
      case 1:
        int isAgreeCount = 0;
        for (TermModel term in signUpData.terms) {
          if (term.termRole == TermRole.essential && term.isAgreed) {
            isAgreeCount += 1;
          }
        }
        status = isAgreeCount == 2;
        return status;
      case 2:
        status = signUpData.idCtrl.text.isNotEmpty && signUpData.idCheck;

        status = status && signUpData.passwordCtrl.text.isNotEmpty && signUpData.passwordConfirmCtrl.text.isNotEmpty;

        status = status && (signUpData.passwordCtrl.text == signUpData.passwordConfirmCtrl.text);

        return status;
      case 3:
        status = signUpData.gender.containsValue(true);
        status = status && signUpData.nameCtrl.text.isNotEmpty;
        status = status && signUpData.phoneCtrl.text.isNotEmpty && signUpData.phoneCheck;

        return status;
      case 4:
        status = signUpData.address1Ctrl.text.isNotEmpty;
        return status;

      default:
        status = signUpData.profileImage != null;

        return status;
    }
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
                  _progressCircle(context: context, progressIdx: 4),
                  _progressCircle(context: context, progressIdx: 5),
                  _progressCircle(context: context, progressIdx: 6),
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
      padding: EdgeInsets.symmetric(
        vertical: 6.0.h,
        horizontal: 12.0.w,
      ),
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
        margin: EdgeInsets.symmetric(vertical: 3.0.h),
        color: const Color(0xFFBABABA).withOpacity(0.25),
        padding: EdgeInsets.symmetric(vertical: 3.0.h),
        borderRadius: BorderRadius.circular(13.0).w,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RememberMeBox(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
              ),
              child: RememberMeText(
                "1",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
            RememberMeBox(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
              ),
              child: RememberMeText(
                "2",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
            RememberMeBox(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
              ),
              child: RememberMeText(
                "3",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
            RememberMeBox(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
              ),
              child: RememberMeText(
                "3",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
            RememberMeBox(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
              ),
              child: RememberMeText(
                "4",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
            RememberMeBox(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0.w,
              ),
              child: RememberMeText(
                "5",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: Colors.transparent,
              ),
            ),
            RememberMeBox(
              child: RememberMeText(
                "6",
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
