import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';

class NostalgiaItemQuizPage extends ConsumerStatefulWidget {
  const NostalgiaItemQuizPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NostalgiaItemQuizPageState();
}

class _NostalgiaItemQuizPageState extends ConsumerState<NostalgiaItemQuizPage> {
  List<String> answers = [
    "양은도시락",
    "삼겹살",
  ];

  @override
  Widget build(BuildContext context) {
    return RememberMeAppBarLayout(
      appBarTitle: "기억력 테스트",
      body: RememberMeBox(
        padding: EdgeInsets.symmetric(vertical: 30.0.h),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  "https://user-images.githubusercontent.com/77563814/224518194-b45c1103-1de2-4e7d-9267-66ae4637c53a.png",
                  width: 0.8.sw,
                ),
                SizedBox(height: 20.0.h),
                Image.asset(
                  "assets/images/question-mark.png",
                  height: 0.15.sw,
                ),
                SizedBox(height: 10.0.h),
                RememberMeText(
                  "위 사진 속 물건의 이름은 무엇일까요?",
                  size: 17.sp,
                  weight: BOLD,
                  color: const Color(0xFF4A4A4A),
                  letterSpacing: -0.68.sp,
                ),
                SizedBox(height: 35.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      answers.map((a) => _answerButton(answer: a)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _answerButton({
    required String answer,
  }) {
    return GestureDetector(
      child: RememberMeBox(
        width: 100.0.w,
        height: 100.0.w,
        margin: EdgeInsets.only(right: 24.0.w),
        borderRadius: BorderRadius.circular(18.0.r),
        borderColor: const Color(0xFFD0D0D0),
        borderWidth: 0.7.w,
        color: WHITE,
        child: Center(
          child: RememberMeText(
            answer,
            size: 16.sp,
            weight: BOLD,
            color: const Color(0xFF707070),
            letterSpacing: -0.64.sp,
          ),
        ),
      ),
    );
  }
}
