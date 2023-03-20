import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';

class WelcomeComponent extends StatelessWidget {
  const WelcomeComponent({
    super.key,
    required this.text,
    required this.widget,
  });

  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: RememberMeText(
              text,
              size: 16.sp,
              weight: BOLD,
              letterSpacing: -0.8.sp,
              align: TextAlign.center,
              color: const Color(0xFF2E2E2E),
            ),
          ),
          SizedBox(height: 110.0.h),
          Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 1.0.sw,
                  height: 0.6.sh,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9A43D7).withOpacity(0.52),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(0.6.sw.r), topRight: Radius.circular(0.6.sw.r)),
                  ),
                ),
              ),
              Positioned(
                top: -67.5.h,
                child: widget,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
