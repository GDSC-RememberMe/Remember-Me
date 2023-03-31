import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_logo.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';
import 'package:remember_me_mobile/home/component/home_page_main_button.dart';

class CaregiverHomePage extends ConsumerStatefulWidget {
  final TabController tabCtrl;

  const CaregiverHomePage({
    super.key,
    required this.tabCtrl,
  });

  @override
  ConsumerState<CaregiverHomePage> createState() => _CaregiverHomePageState();
}

class _CaregiverHomePageState extends ConsumerState<CaregiverHomePage> {
  ScrollController scrollCtrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      body: NestedScrollView(
        controller: scrollCtrl,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              titleSpacing: 0.0,
              elevation: 0.0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings_rounded),
                color: WHITE,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                disabledColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              title: const RememberMeLogo(color: WHITE),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_rounded),
                  color: WHITE,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary,
                          WHITE,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.5, 0.5],
                      ),
                    ),
                    child: const _PatientProfile(),
                  ),
                ],
              ),
            )
          ];
        },
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          children: [
            _MainButtons(
              tabCtrl: widget.tabCtrl,
            ),
          ],
        ),
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
    return RememberMeBox(
      padding: EdgeInsets.only(
        top: 22.h,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 30.h,
      ),
      color: WHITE,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF727272).withOpacity(0.20),
          offset: const Offset(2, 3),
          blurRadius: 15.0,
        ),
      ],
      child: Column(
        children: [
          RememberMeBox(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
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
              ],
            ),
          ),
          SizedBox(height: 22.h),
          RememberMeBox(
            color: const Color(0xFF939393),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
              vertical: 10.h,
            ),
            child: Row(
              children: [
                RememberMeText(
                  "아버지 상세정보",
                  size: 13.sp,
                  weight: BOLD,
                  letterSpacing: -0.26.sp,
                  color: WHITE,
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, color: WHITE, size: 21.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileImg() {
    return Container(
      width: 80.w,
      height: 80.w,
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
          fontSize: 17.sp,
          letterSpacing: -0.34.sp,
          color: const Color(0xFF4E4E4E),
        ),
        children: [
          TextSpan(
            text: "할아버님",
            style: TextStyle(
              fontWeight: MEDIUM,
              fontSize: 14.sp,
              letterSpacing: -0.28.sp,
              color: const Color(0xFF4E4E4E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ageAndStep() {
    return RememberMeText(
      "81세 | 3급",
      size: 12.sp,
      weight: BOLD,
      letterSpacing: -0.24.sp,
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
          color: const Color(0xFF585858),
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

class _MainButtons extends StatelessWidget {
  final TabController tabCtrl;

  const _MainButtons({
    super.key,
    required this.tabCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return RememberMeBox(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          HomePageMainButton(
            title: "추억 회상",
            subtitle: "아버지와 함께했던 기억들을\n기록하고, 공유해 보세요!",
            imgPath: "favorite-folder.png",
            onTap: () {
              tabCtrl.animateTo(0);
            },
          ),
          SizedBox(height: 20.0.h),
          HomePageMainButton(
            title: "인지능력 체크",
            subtitle: "아버지가 얼마나 기억을 하고 계시는지\n퀴즈와 게임을 통해 확인, 분석할 수 있습니다",
            imgPath: "positive-mind.png",
            onTap: () {
              tabCtrl.animateTo(1);
            },
          ),
          SizedBox(height: 20.0.h),
          HomePageMainButton(
            title: "커뮤니티",
            subtitle: "치매 환우와 함께하는 사람들과\n다양한 정보를 공유하고 소통하는 공간입니다",
            imgPath: "internet.png",
            onTap: () {
              tabCtrl.animateTo(3);
            },
          ),
        ],
      ),
    );
  }
}
