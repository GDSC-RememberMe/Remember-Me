import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/fonts.dart';
import 'package:remember_me_mobile/common/layout/default_layout.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return _OnBoardingWithTypo();
  }
}

class _OnBoardingWithLogo extends StatelessWidget {
  const _OnBoardingWithLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class _OnBoardingWithTypo extends StatelessWidget {
  _OnBoardingWithTypo({
    super.key,
  });

  final baseTextStyle = TextStyle(
    color: const Color(0xFF707070),
    fontFamily: NOTO_SANS,
    fontSize: 20.sp,
    fontWeight: MEDIUM,
    letterSpacing: -1.05.sp,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: SafeArea(
        child: RememberMeBox(
          padding: const EdgeInsets.symmetric(vertical: 104, horizontal: 28).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "만나서 반가워요.\n",
                      style: baseTextStyle,
                    ),
                    TextSpan(
                      text: "치매가족의 삶의 질을 올려 줄 서비스,\n",
                      style: baseTextStyle,
                    ),
                    TextSpan(
                      text: "리멤버미 ",
                      style: baseTextStyle.copyWith(fontWeight: BOLD),
                    ),
                    TextSpan(
                      text: "입니다.",
                      style: baseTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
