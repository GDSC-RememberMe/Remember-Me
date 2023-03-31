import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';
import 'package:remember_me_mobile/setting/component/setting_menu.dart';
import 'package:remember_me_mobile/user/provider/current_user_provider.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return RememberMeAppBarLayout(
      appBarTitle: "설정",
      body: ListView(
        padding: EdgeInsets.all(30.0.w),
        children: [
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      RememberMeBox(
                        width: 50.0.w,
                        height: 50.0.w,
                        color: const Color(0xFFD5D5D5),
                        shape: BoxShape.circle,
                        child: Center(
                          child: Icon(
                            Icons.person_outline_rounded,
                            size: 30.w,
                            color: WHITE,
                          ),
                        ),
                      ),
                      SizedBox(width: 24.0.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "박연우",
                              style: TextStyle(
                                fontWeight: BOLD,
                                fontSize: 17.sp,
                                letterSpacing: -0.68.sp,
                                color: const Color(0xFF363636),
                              ),
                              children: [
                                TextSpan(
                                  text: "님 안녕하세요!",
                                  style: TextStyle(
                                    fontWeight: MEDIUM,
                                    fontSize: 17.sp,
                                    letterSpacing: -0.68.sp,
                                    color: const Color(0xFF363636),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RememberMeText(
                            "jeongyeonu9 @ google.com",
                            size: 12.sp,
                            weight: MEDIUM,
                            letterSpacing: -0.48.sp,
                            color: const Color(0xFF939393),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0.h),
                  RememberMeBox(
                    padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 14.0.w),
                    color: const Color(0xFFD5D3D3),
                    borderRadius: BorderRadius.circular(12.0.w),
                    child: RememberMeText(
                      "프로필 수정",
                      size: 13.sp,
                      weight: MEDIUM,
                      letterSpacing: -0.15.sp,
                      color: WHITE,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFFE2E2E2),
              ),
            ],
          ),
          SizedBox(height: 20.0.h),
          const Divider(),
          SizedBox(height: 20.0.h),
          const _PatientProfile(),
          SizedBox(height: 25.0.h),
          SettingMenu(
            onTap: () {},
            icon: Icons.military_tech_outlined,
            title: "우리 가족 배지",
          ),
          SizedBox(height: 25.0.h),
          SettingMenu(
            onTap: () {},
            icon: Icons.family_restroom_outlined,
            title: "가족 정보 수정",
          ),
          SizedBox(height: 25.0.h),
          SettingMenu(
            onTap: () {},
            icon: Icons.notifications_outlined,
            title: "푸시 알림 설정",
          ),
          SizedBox(height: 25.0.h),
          SettingMenu(
            onTap: () {
              ref.read(currentUserNotifierProvider.notifier).logout();
            },
            icon: Icons.logout_outlined,
            title: "로그아웃",
          ),
        ],
      ),
    );
  }
}

class _PatientProfile extends ConsumerWidget {
  const _PatientProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RememberMeText(
          "나의 가족 프로필",
          size: 15.sp,
          weight: BOLD,
          letterSpacing: -0.6.sp,
          color: const Color(0xFF363636),
        ),
        SizedBox(height: 11.5.h),
        RememberMeBox(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 18.h,
          ),
          color: const Color(0xFFE1E2E1).withOpacity(0.36),
          borderRadius: BorderRadius.circular(8.r),
          child: RememberMeBox(
            child: Row(
              children: [
                _profileImg(),
                SizedBox(width: 15.0.w),
                RememberMeBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _name(),
                          SizedBox(width: 10.w),
                          _ageAndStep(),
                        ],
                      ),
                      SizedBox(height: 10.0.h),
                      _progressIndicator(),
                    ],
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: const Color(0xFF707070),
                  size: 15.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _profileImg() {
    return Container(
      width: 55.0.w,
      height: 55.0.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            "https://images.unsplash.com/photo-1444069069008-83a57aac43ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2487&q=80",
          ),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _name() {
    return RichText(
      text: TextSpan(
        text: "박종원 ",
        style: TextStyle(
          fontWeight: BOLD,
          fontSize: 14.sp,
          letterSpacing: -0.34.sp,
          color: const Color(0xFF707070),
        ),
        children: [
          TextSpan(
            text: "할아버님",
            style: TextStyle(
              fontWeight: MEDIUM,
              fontSize: 13.sp,
              letterSpacing: -0.52.sp,
              color: const Color(0xFF707070),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ageAndStep() {
    return RememberMeText(
      "81세 | 3급",
      size: 11.sp,
      weight: BOLD,
      letterSpacing: -0.33.sp,
      color: const Color(0xFF939393),
    );
  }

  Widget _progressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RememberMeText(
          "치매 진행도",
          weight: BOLD,
          size: 9.sp,
          letterSpacing: -0.18.sp,
          color: const Color(0xFF707070),
        ),
        SizedBox(height: 4.0.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              width: 0.4.sw,
              lineHeight: 14.0.h,
              percent: 71 / 100,
              barRadius: Radius.circular(8.r),
              backgroundColor: const Color(0xFFEAEAEA),
              progressColor: const Color(0xFF80DE92),
            ),
            SizedBox(width: 5.0.w),
            RememberMeText(
              "71/100",
              size: 9.sp,
              letterSpacing: -0.18.sp,
              color: const Color(0xFF939393),
            ),
          ],
        ),
      ],
    );
  }
}
