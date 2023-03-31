import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';
import 'package:remember_me_mobile/home/component/home_page_main_button.dart';
import 'package:remember_me_mobile/memory_check/view/patient_memory_check_page.dart';
import 'package:remember_me_mobile/nostalgia_item/view/nostalgia_item_quiz_page.dart';
import 'package:remember_me_mobile/user/provider/current_user_provider.dart';

class MemoryQuizSelectPage extends ConsumerStatefulWidget {
  const MemoryQuizSelectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryQuizSelectPageState();
}

class _MemoryQuizSelectPageState extends ConsumerState<MemoryQuizSelectPage> {
  @override
  Widget build(BuildContext context) {
    return RememberMeAppBarLayout(
      appBarTitle: "기억 확인",
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
        child: Center(
          child: RememberMeBox(
            padding: EdgeInsets.symmetric(horizontal: 35.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomePageMainButton(
                  title: "추억의 물건 게임",
                  subtitle: "재미난 옛 물건들로 가득,\n과거의 기억들을 맞추어 볼까요?",
                  imgPath: "red-and-blue-ddakji.png",
                  onTap: () {
                    context.pushNamed(NostalgiaItemQuizPage.routeName);
                  },
                ),
                SizedBox(height: 20.0.h),
                HomePageMainButton(
                  title: "추억 회상 퀴즈",
                  subtitle: "우리 가족들의 옛 모습과 목소리를 들으며,\n예전의 우리를 떠올려 볼까요?",
                  imgPath: "faq-search-glass.png",
                  onTap: () {
                    context.pushNamed(PatientMemoryCheckPage.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
