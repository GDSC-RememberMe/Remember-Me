import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/text.dart';

class ContainedButton extends StatefulWidget {
  final void Function() onTap;
  final String text;
  final Color buttonColor;
  final Color textColor;

  const ContainedButton(
    this.text, {
    Key? key,
    required this.onTap,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  State<ContainedButton> createState() => _ContainedButtonState();
}

class _ContainedButtonState extends State<ContainedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: RememberMeBox(
        padding: EdgeInsets.symmetric(vertical: 11.0.h),
        width: double.infinity,
        color: widget.buttonColor,
        borderRadius: BorderRadius.circular(22.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RememberMeText(
              widget.text,
              size: 12.sp,
              weight: BOLD,
              letterSpacing: -0.6.sp,
              color: widget.textColor,
            ),
          ],
        ),
      ),
    );
  }
}
