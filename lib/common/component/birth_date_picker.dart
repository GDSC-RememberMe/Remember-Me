import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';

class BirthDatePicker extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;

  const BirthDatePicker({
    required this.onDateTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final initDate = DateFormat('yyyy-MM-dd').parse("1950-01-01");
    return RememberMeBox(
      margin: EdgeInsets.symmetric(horizontal: 12.0.w),
      child: SizedBox(
        height: 100.0.h,
        child: CupertinoDatePicker(
          minimumYear: 1900,
          maximumYear: DateTime.now().year,
          initialDateTime: initDate,
          maximumDate: DateTime.now(),
          onDateTimeChanged: onDateTimeChanged,
          mode: CupertinoDatePickerMode.date,
        ),
      ),
    );
  }
}
