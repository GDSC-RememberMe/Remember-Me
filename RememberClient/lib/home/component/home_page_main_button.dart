import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';

class HomePageMainButton extends StatelessWidget {
  const HomePageMainButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imgPath,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String imgPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 26.0.h),
        decoration: BoxDecoration(
          color: WHITE,
          borderRadius: BorderRadius.circular(20.0.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF727272).withOpacity(0.20),
              offset: const Offset(2, 3),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RememberMeText(
                    title,
                    size: 17.sp,
                    letterSpacing: -0.34.sp,
                    color: const Color(0xFF707070),
                    weight: BOLD,
                  ),
                  SizedBox(height: 5.0.h),
                  RememberMeText(
                    subtitle,
                    size: 11.sp,
                    letterSpacing: -0.22.sp,
                    color: const Color(0xFF969696),
                    weight: MEDIUM,
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/images/$imgPath",
              width: 0.1.sw,
            ),
          ],
        ),
      ),
    );
  }
}
