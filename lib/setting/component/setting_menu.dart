import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/text.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });
  final VoidCallback onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RememberMeBox(
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF363636),
              size: 17.0.w,
            ),
            SizedBox(width: 12.0.w),
            RememberMeText(
              title,
              size: 14.sp,
              weight: REGULAR,
              color: const Color(0xFF363636),
              letterSpacing: -0.56.sp,
            ),
          ],
        ),
      ),
    );
  }
}
