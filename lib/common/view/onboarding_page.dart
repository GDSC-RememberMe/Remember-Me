import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/contained_button.dart';
import 'package:remember_me_mobile/common/component/onboarding_page_views.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/component/welcome_component.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';
import 'package:remember_me_mobile/common/view/caregiver_main_tab_page.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({super.key});

  @override
  ConsumerState<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  final PageController _pageCtrl = PageController(
    initialPage: 0,
  );

  int _currentIdx = 0;

  final List<Widget> _onBoardingPages = [
    const OnBoardingFirstPageView(),
    OnBoardingSecondPageView(),
    const OnBoardingThirdPageView(),
    const OnBoardingFourthPageView(),
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
              text: "환영합니다!\n이제 리멤버미를 이용할 준비가 되었어요.",
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    width: 135.0.w,
                    height: 135.0.w,
                  ),
                  SizedBox(height: 18.0.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RememberMeText(
                        "박종원 ",
                        size: 15.sp,
                        weight: BOLD,
                        letterSpacing: -0.3.sp,
                        color: WHITE,
                      ),
                      RememberMeText(
                        "할아버님",
                        size: 12.sp,
                        weight: MEDIUM,
                        letterSpacing: -0.24.sp,
                        color: WHITE,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0.h),
                  RememberMeBox(
                    borderRadius: BorderRadius.circular(9.0.r),
                    color: WHITE,
                    padding: EdgeInsets.symmetric(
                      vertical: 4.0.h,
                      horizontal: 16.0.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF727272).withOpacity(0.20),
                        offset: const Offset(0, 3),
                        blurRadius: 6.0,
                      ),
                    ],
                    child: RememberMeText(
                      "아버지",
                      size: 13.sp,
                      weight: BOLD,
                      letterSpacing: -0.26.sp,
                      color: const Color(0xFF838383),
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: RememberMeLayout(
              body: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      top: 20.0.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (idx) {
                          return _currentIdx == idx ? _activatedProgressBar(context) : _deactivatedProgressBar();
                        }),
                      ),
                    ),
                    PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageCtrl,
                      onPageChanged: (idx) {
                        setState(() {
                          _currentIdx = idx;
                        });
                      },
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 15.5.h, horizontal: 28.w),
                          child: RememberMeBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 46.5.h),
                                _onBoardingPages[index],
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
    if (_currentIdx < 3) {
      if (_currentIdx == 2 && ref.watch(onBoardingThirdPageViewIdxProvider.notifier).state < 2) {
        ref.watch(onBoardingThirdPageViewIdxProvider.notifier).update((state) => state + 1);
        return;
      }
      setState(() {
        _currentIdx = _currentIdx + 1;
      });
      _pageCtrl.animateToPage(_currentIdx, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      return;
    } else {
      setState(() {
        _visible = true;
      });

      Future.delayed(
        const Duration(milliseconds: 3500),
      ).then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CaregiverMainTabPage(),
          ),
        );
      });
    }
  }

  Widget _activatedProgressBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
      width: 60.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(5.0.r),
      ),
    );
  }

  Widget _deactivatedProgressBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0.w),
      width: 18.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: const Color(0xFF707070).withOpacity(0.6),
        borderRadius: BorderRadius.circular(5.0.r),
      ),
    );
  }
}
