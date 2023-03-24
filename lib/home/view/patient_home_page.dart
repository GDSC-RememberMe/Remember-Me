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

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({
    super.key,
    required this.tabCtrl,
  });

  final TabController tabCtrl;

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: WHITE,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_rounded),
          color: Theme.of(context).colorScheme.primary,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          disabledColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        title: const RememberMeLogo(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_rounded),
            color: Theme.of(context).colorScheme.primary,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            disabledColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 40.0.h,
          bottom: 100.0.h,
        ),
        children: [
          const _PatientProfile(),
          SizedBox(height: 32.0.h),
          _MainButtons(
            tabCtrl: widget.tabCtrl,
          ),
        ],
      ),
    );
  }
}

class _PatientProfile extends StatelessWidget {
  const _PatientProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _profileImg(),
        SizedBox(height: 20.h),
        RememberMeBox(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 30.w,
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _name(),
              SizedBox(height: 4.0.h),
              _ageAndStep(),
              SizedBox(height: 13.0.h),
              // _progressIndicator(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileImg() {
    return Container(
      width: 150.w,
      height: 150.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE8E8E8),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            "https://images.unsplash.com/photo-1444069069008-83a57aac43ac?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2487&q=80",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _name() {
    return RichText(
      text: TextSpan(
        text: "박종원",
        style: TextStyle(
          fontWeight: BOLD,
          fontSize: 17.sp,
          letterSpacing: -0.34.sp,
          color: const Color(0xFF4E4E4E),
        ),
        children: [
          TextSpan(
            text: "님",
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
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
                  children: [
                    LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      width: 0.6.sw,
                      lineHeight: 14.0.h,
                      percent: 71 / 100,
                      barRadius: Radius.circular(8.r),
                      backgroundColor: WHITE,
                      progressColor: const Color(0xFF80DE92),
                    ),
                    SizedBox(width: 8.0.w),
                    RememberMeText(
                      "71/100",
                      size: 9.sp,
                      letterSpacing: -0.18.sp,
                      color: const Color(0xFF939393),
                    ),
                  ],
                ),
              ],
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
            title: "추억 회상하러 가실까요?",
            subtitle: "가족들과 함께했던 기억들을\n사진과 동영상으로 떠올려 보아요",
            imgPath: "favorite-folder.png",
            onTap: () {
              tabCtrl.animateTo(0);
            },
          ),
          SizedBox(height: 20.0.h),
          HomePageMainButton(
            title: "나의 기억을 확인해 볼까요?",
            subtitle: "내가 얼마나 기억을 하고 있는지 퀴즈와\n게임을 통해 확인하고 치매를 예방할 수 있어요",
            imgPath: "positive-mind.png",
            onTap: () {
              tabCtrl.animateTo(2);
            },
          ),
        ],
      ),
    );
  }
}
