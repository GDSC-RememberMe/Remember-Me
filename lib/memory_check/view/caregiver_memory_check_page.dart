import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_calendar_model.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_result_model.dart';
import 'package:remember_me_mobile/nostalgia_item/provider/nostalgia_result_provider.dart';
import 'package:remember_me_mobile/nostalgia_item/view/nostalgia_item_book_page.dart';
import 'package:table_calendar/table_calendar.dart';

class CaregiverMemoryCheckPage extends ConsumerStatefulWidget {
  const CaregiverMemoryCheckPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CaregiverMemoryCheckPageState();
}

class _CaregiverMemoryCheckPageState extends ConsumerState<CaregiverMemoryCheckPage> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  NostalgiaCalendarModel? selectedDayNostalgiaCalendar;
  int selectedDayNostalgiaResult = 0;

  @override
  void initState() {
    super.initState();
    final result = ref.read(nostalgiaResultProvider);
    for (NostalgiaCalendarModel cm in result) {
      if (isSameDay(cm.when, selectedDay)) {
        selectedDayNostalgiaCalendar = cm;
      }
    }

    int count = 0;

    if (selectedDayNostalgiaCalendar != null) {
      for (NostalgiaResultModel rm in selectedDayNostalgiaCalendar!.nostalgiaResults) {
        if (rm.result) {
          count++;
        }
      }

      selectedDayNostalgiaResult = count;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RememberMeAppBarLayout(
      appBarTitle: "인지체크",
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 44.0.w, vertical: 35.0.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RememberMeBox(
                borderColor: const Color(0xFFAFAFAF),
                borderRadius: BorderRadius.circular(5.0.r),
                borderWidth: 0.2.w,
                color: const Color(0xFFDCE6EA),
                padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 6.0.w),
                child: RememberMeText(
                  "추억 회상",
                  size: 13.sp,
                  weight: BOLD,
                  color: const Color(0xFF848484),
                  letterSpacing: -0.26.sp,
                ),
              ),
              RememberMeBox(
                borderColor: const Color(0xFFAFAFAF),
                borderRadius: BorderRadius.circular(5.0.r),
                borderWidth: 0.2.w,
                color: const Color(0xFFB87BE3),
                padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 9.0.w),
                child: RememberMeText(
                  "추억의 물건",
                  size: 13.sp,
                  weight: BOLD,
                  color: WHITE,
                  letterSpacing: -0.26.sp,
                ),
              ),
              RememberMeBox(
                borderColor: const Color(0xFFAFAFAF),
                borderRadius: BorderRadius.circular(5.0.r),
                borderWidth: 0.2.w,
                color: const Color(0xFFDCE6EA),
                padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 6.0.w),
                child: RememberMeText(
                  "추억 회상",
                  size: 13.sp,
                  weight: BOLD,
                  color: const Color(0xFF848484),
                  letterSpacing: -0.26.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0.h),
          Center(
            child: GestureDetector(
              onTap: () {
                context.pushNamed(NostalgiaItemBookPage.routeName);
              },
              child: RememberMeBox(
                borderColor: const Color(0xFFB87BE3),
                borderRadius: BorderRadius.circular(5.0.r),
                borderWidth: 0.1.w,
                color: WHITE,
                padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 9.0.w),
                child: RememberMeText(
                  "도감 보기",
                  size: 13.sp,
                  weight: MEDIUM,
                  color: const Color(0xFF848484),
                  letterSpacing: -0.26.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0.h),
          _table(),
          SizedBox(height: 30.0.h),
          Row(
            children: [
              RememberMeText(
                DateFormat('MM월 dd일 EEEE', "ko_KR").format(selectedDay),
                size: 16.sp,
                weight: BOLD,
                color: const Color(0xFF848484),
                letterSpacing: -0.32.sp,
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: "$selectedDayNostalgiaResult",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: BOLD,
                    color: const Color(0xFFCD8ED8),
                    letterSpacing: -0.26.sp,
                  ),
                  children: [
                    TextSpan(
                      text: " / 5",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: BOLD,
                        color: const Color(0xFF9B9B9B),
                        letterSpacing: -0.26.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 25.0.h),
          if (selectedDayNostalgiaCalendar != null)
            SizedBox(
              height: 0.6.sw,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: selectedDayNostalgiaCalendar!.nostalgiaResults.length,
                itemBuilder: (context, index) {
                  final result = selectedDayNostalgiaCalendar!.nostalgiaResults[index];
                  return Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: result.imgUrl,
                        width: 0.15.sw,
                        color: !result.result ? WHITE.withOpacity(0.60) : null,
                        colorBlendMode: !result.result ? BlendMode.lighten : null,
                      ),
                      SizedBox(height: 10.0.h),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  RememberMeBox _table() {
    return RememberMeBox(
      borderRadius: BorderRadius.circular(24.0.r),
      borderColor: const Color(0xFFF2F2F2),
      color: WHITE,
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF8E8E8E).withOpacity(0.3),
          blurRadius: 6.0,
          spreadRadius: 1.0,
          offset: const Offset(0, 3),
        ),
      ],
      padding: EdgeInsets.symmetric(vertical: 17.0.h, horizontal: 28.0.w),
      child: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2023, 3, 1),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: focusedDay,
        onDaySelected: (DateTime sd, DateTime fd) {
          setState(() {
            selectedDay = sd;
            focusedDay = fd;
            selectedDayNostalgiaCalendar = null;
          });
          final result = ref.watch(nostalgiaResultProvider);

          print(result.length);
          for (NostalgiaCalendarModel cm in result) {
            if (isSameDay(cm.when, fd)) {
              setState(() {
                selectedDayNostalgiaCalendar = cm;
              });
            }
          }

          int count = 0;

          if (selectedDayNostalgiaCalendar != null) {
            for (NostalgiaResultModel rm in selectedDayNostalgiaCalendar!.nostalgiaResults) {
              if (rm.result) {
                count++;
              }
            }

            setState(() {
              selectedDayNostalgiaResult = count;
            });
          } else {
            setState(() {
              selectedDayNostalgiaResult = 0;
            });
          }
        },
        selectedDayPredicate: (DateTime day) {
          return isSameDay(selectedDay, day);
        },
        onPageChanged: (focusedDay) {
          ref.read(nostalgiaResultProvider.notifier).getNostalgiaResults(month: focusedDay.month);
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) => "${date.month}월 기억캘린더",
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontSize: 14.0.sp,
            fontWeight: BOLD,
            color: const Color(0xFF2C2C2C),
            letterSpacing: -0.31.sp,
          ),
          leftChevronIcon: Icon(
            Icons.arrow_back_ios,
            size: 16.0,
            color: const Color(0xFF8E8E8E).withOpacity(0.76),
          ),
          leftChevronPadding: EdgeInsets.zero,
          leftChevronMargin: EdgeInsets.zero,
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios,
            size: 16.0,
            color: const Color(0xFF8E8E8E).withOpacity(0.76),
          ),
          rightChevronPadding: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5.w,
                color: const Color(0xFF8E8E8E).withOpacity(0.76),
              ),
            ),
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontSize: 10.0.sp,
            fontWeight: BOLD,
            color: const Color(0xFF8E8E8E),
          ),
          weekendStyle: TextStyle(
            fontSize: 10.0.sp,
            fontWeight: BOLD,
            color: const Color(0xFF8E8E8E),
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          tablePadding: EdgeInsets.symmetric(vertical: 10.0.h),
          isTodayHighlighted: false,
        ),
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, day, focusedDay) {
            return Container(
              width: 20.0.w,
              height: 20.0.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8E8E8E).withOpacity(0.3),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "${day.day}",
                  style: TextStyle(
                    fontSize: 10.0.sp,
                    fontWeight: BOLD,
                    color: WHITE,
                  ),
                ),
              ),
            );
          },
          defaultBuilder: (context, day, event) {
            final result = ref.watch(nostalgiaResultProvider);
            for (NostalgiaCalendarModel e in result) {
              int _count = 0;
              for (NostalgiaResultModel r in e.nostalgiaResults) {
                if (r.result) {
                  _count++;
                }
              }
              return Container(
                width: 20.0.w,
                height: 20.0.w,
                decoration: BoxDecoration(
                  color: isSameDay(e.when, day)
                      ? Theme.of(context).colorScheme.primary.withOpacity(_count == 1
                          ? 0.27
                          : _count < 4
                              ? 0.45
                              : 0.75)
                      : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${day.day}",
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      fontWeight: MEDIUM,
                      color: WHITE,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
