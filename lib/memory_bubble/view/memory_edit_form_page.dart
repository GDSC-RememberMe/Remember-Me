import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';

class MemoryEditFormPage extends ConsumerStatefulWidget {
  const MemoryEditFormPage({super.key});

  static String get routeName => "memory_edit_form";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryEditFormPageState();
}

class _MemoryEditFormPageState extends ConsumerState<MemoryEditFormPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final TextStyle baseTextFormFieldStyle = TextStyle(
    fontSize: 11.0.sp,
    fontWeight: BOLD,
    color: const Color(0xFF707070),
    letterSpacing: -0.22.sp,
  );

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return RememberMeAppBarLayout(
      appBarTitle: "추억 회상",
      isNeedBackButton: true,
      body: _visible
          ? AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 0),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/check.png",
                        width: 0.5.sw,
                      ),
                      SizedBox(height: 15.0.h),
                      RememberMeText(
                        "등록이 성공적으로 완료되었습니다.",
                        size: 17.sp,
                        weight: BOLD,
                        color: const Color(0xFF707070),
                        letterSpacing: -0.34.sp,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 27.5.w,
                vertical: 20.0.h,
              ),
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/pencil-folder.png",
                      width: 0.1.sw,
                    ),
                    SizedBox(width: 8.0.w),
                    RememberMeText(
                      "추억 기록하기",
                      size: 17.sp,
                      weight: BOLD,
                      color: const Color(0xFF707070),
                      letterSpacing: -0.34.sp,
                    ),
                  ],
                ),
                SizedBox(height: 20.0.h),
                GestureDetector(
                  onTap: () {
                    // TODO Image picker 붙이기
                  },
                  child: RememberMeBox(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 60.0.h),
                    color: const Color(0xFFF4F6FD),
                    borderColor: const Color(0xFF9F9F9F),
                    borderWidth: 0.7.w,
                    borderRadius: BorderRadius.circular(11.0.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_rounded,
                          size: 48.0.w,
                          color: const Color(0xFF6F7070),
                        ),
                        SizedBox(height: 17.0.h),
                        RememberMeText(
                          "아버지와의 추억이 담긴 사진을 업로드해 주세요.",
                          align: TextAlign.center,
                          size: 13.5.sp,
                          weight: MEDIUM,
                          color: const Color(0xFF929497),
                          letterSpacing: -0.27.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 17.0.h),
                RememberMeText(
                  "위치는 어디였나요?",
                  size: 13.sp,
                  weight: BOLD,
                  color: const Color(0xFF535353),
                  letterSpacing: -0.26.sp,
                ),
                SizedBox(height: 5.0.h),
                TextFormField(
                  controller: _searchCtrl,
                  style: baseTextFormFieldStyle.copyWith(
                    color: GREY900,
                  ),
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF4F6FD),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 9.0.h),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.7.w,
                        color: const Color(0xFF9F9F9F),
                      ),
                      borderRadius: BorderRadius.circular(11.0.r),
                    ),
                    hintText: "시, 군, 구 검색",
                    hintStyle: baseTextFormFieldStyle,
                    suffixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF696969),
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
                const Divider(
                  color: Color(0xFF9F9F9F),
                ),
                SizedBox(height: 10.0.h),
                RememberMeText(
                  "위치는 어디였나요?",
                  size: 13.sp,
                  weight: BOLD,
                  color: const Color(0xFF535353),
                  letterSpacing: -0.26.sp,
                ),
                SizedBox(height: 5.0.h),
                RememberMeText(
                  "아버지께 추억을 자유롭게 설명해 보세요!",
                  size: 11.sp,
                  weight: MEDIUM,
                  color: const Color(0xFF535353),
                  letterSpacing: -0.22.sp,
                ),
                SizedBox(height: 10.0.h),
                _descriptionButton(
                  onTap: () {},
                  icon: Icons.edit_rounded,
                  title: "글로 설명해 드리기",
                ),
                SizedBox(height: 10.0.h),
                _descriptionButton(
                  onTap: () {},
                  icon: Icons.mic_rounded,
                  title: "목소리로 설명해 드리기",
                ),
                SizedBox(height: 50.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _submitButton(
                      onTap: () {
                        context.pop();
                      },
                      title: "입력 취소",
                      color: const Color(0xFFFAF5F5),
                    ),
                    SizedBox(width: 27.0.w),
                    _submitButton(
                      onTap: () {
                        setState(() {
                          _visible = true;
                        });
                        // TODO 뒤로 나가는 로직 구현
                      },
                      title: "등록",
                      color: WHITE,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _descriptionButton({
    required VoidCallback onTap,
    required IconData icon,
    required String title,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            color: const Color(0xFF6F7070),
          ),
          SizedBox(width: 5.0.w),
          RememberMeBox(
            width: 0.7.sw,
            child: RememberMeBox(
              color: const Color(0xFFF4F6FD),
              borderColor: const Color(0xFF9F9F9F),
              borderWidth: 0.7.w,
              borderRadius: BorderRadius.circular(11.0.r),
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
              child: RememberMeText(
                title,
                size: 11.sp,
                weight: BOLD,
                color: const Color(0xFF707070),
                letterSpacing: -0.22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton({
    required VoidCallback onTap,
    required String title,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: RememberMeBox(
        child: RememberMeBox(
          color: color,
          borderColor: const Color(0xFF707070),
          borderWidth: 0.7.w,
          borderRadius: BorderRadius.circular(11.0.r),
          padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.0.h),
          child: RememberMeText(
            title,
            size: 13.sp,
            weight: BOLD,
            color: const Color(0xFF707070),
            letterSpacing: -0.26.sp,
          ),
        ),
      ),
    );
  }
}
