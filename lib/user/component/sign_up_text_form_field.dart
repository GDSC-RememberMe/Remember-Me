import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';

class SignUpTextFormField extends StatelessWidget {
  SignUpTextFormField({
    super.key,
    required this.ctrl,
    required this.hintText,
    this.constraints,
    this.obscureText = false,
    this.onChanged,
    this.readOnly = false,
  });

  final TextEditingController ctrl;
  final String hintText;
  final BoxConstraints? constraints;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

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
      readOnly: readOnly,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5.w,
            color: const Color(
              0xFFA0A0A0,
            ),
          ),
        ),
        hintText: hintText,
        hintStyle: baseStyle,
        constraints: constraints,
      ),
    );
  }
}
