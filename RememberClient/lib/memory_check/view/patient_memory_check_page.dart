import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_app_bar.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';

class PatientMemoryCheckPage extends ConsumerStatefulWidget {
  const PatientMemoryCheckPage({super.key});

  static String get routeName => "patient_memory_check";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientMemoryCheckPageState();
}

class _PatientMemoryCheckPageState extends ConsumerState<PatientMemoryCheckPage> {
  List<String> answers = [
    "1. 작은아들",
    "2. 큰아들",
    "3. 아내",
    "4. 작은딸",
  ];

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      appBar: const RememberMeAppBar(
        title: "기억 확인",
        isNeedBackButton: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 35.0.w,
          vertical: 40.0.h,
        ),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18.0.r),
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: Image.asset(
                "assets/images/children.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 40.0.h),
          Image.asset(
            "assets/images/question-mark.png",
            height: 0.15.sw,
          ),
          SizedBox(height: 10.0.h),
          Stack(
            children: [
              Column(
                children: [
                  RememberMeText(
                    "누구와 함께했던 기억인가요?",
                    size: 17.sp,
                    weight: BOLD,
                    color: const Color(0xFF4A4A4A),
                    letterSpacing: -0.68.sp,
                  ),
                  SizedBox(height: 5.0.h),
                  RememberMeText(
                    "(중복 선택 가능)",
                    size: 14.sp,
                    weight: MEDIUM,
                    color: const Color(0xFF707070),
                    letterSpacing: -0.56.sp,
                  ),
                  SizedBox(height: 30.0.h),
                  ...answers.map((a) => _answerButton(answer: a)).toList(),
                  SizedBox(height: 50.0.h),
                ],
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Icon(
              //     Icons.circle_outlined,
              //     color: const Color(0xFFCB0404),
              //     size: 0.5.sw,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _answerButton({
    required String answer,
  }) {
    return GestureDetector(
      child: RememberMeBox(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 10.0.h,
        ),
        margin: EdgeInsets.only(bottom: 20.0.h),
        borderRadius: BorderRadius.circular(11.0.r),
        borderColor: const Color(0xFF9F9F9F),
        borderWidth: 0.7.w,
        color: const Color(0xFFF2E8F9),
        child: Center(
            child: RememberMeText(answer,
                size: 16.sp, weight: MEDIUM, color: const Color(0xFF707070), letterSpacing: -0.64.sp)),
      ),
    );
  }
}
