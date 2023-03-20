import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';

class RememberMeLogo extends StatelessWidget {
  final Color? color;
  const RememberMeLogo({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RememberMeText(
      "Remember Me",
      size: 17.sp,
      fontFamily: "Unbounded",
      letterSpacing: -0.34.sp,
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }
}
