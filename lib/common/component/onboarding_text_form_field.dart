import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';

class OnBoardingTextFormField extends StatelessWidget {
  OnBoardingTextFormField({
    super.key,
    required this.ctrl,
    required this.hintText,
    this.constraints,
    this.obscureText = false,
    this.onChanged,
  });

  final TextEditingController ctrl;
  final String hintText;
  final BoxConstraints? constraints;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  final TextStyle baseStyle = TextStyle(
    fontSize: 10.0.sp,
    fontWeight: BOLD,
    color: const Color(0xFFA5A5A5),
    letterSpacing: -0.4.sp,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: ctrl,
      style: baseStyle.copyWith(
        color: GREY900,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 9.0.w, vertical: 0.0.w),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0.w,
            color: const Color(
              0xFFAAAAAA,
            ),
          ),
          borderRadius: BorderRadius.circular(4.0.r),
        ),
        hintText: hintText,
        hintStyle: baseStyle,
        constraints: constraints,
      ),
    );
  }
}
