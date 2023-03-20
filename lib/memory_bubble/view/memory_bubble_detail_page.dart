import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_app_bar.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';

class MemoryBubbleDetailPage extends ConsumerStatefulWidget {
  static String get routeName => "memory_bubble_detail";

  final String imgUrl;
  final bool isFromPatient;

  const MemoryBubbleDetailPage({
    super.key,
    required this.imgUrl,
    required this.isFromPatient,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryBubbleDetailPageState();
}

class _MemoryBubbleDetailPageState extends ConsumerState<MemoryBubbleDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      appBar: const RememberMeAppBar(
        title: "추억 회상",
        isNeedBackButton: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            Stack(
              children: [
                _memoryImg(),
                _dateAndTitle(),
              ],
            ),
            RememberMeBox(
              padding: EdgeInsets.symmetric(
                horizontal: 23.5.w,
              ),
              child: Column(
                children: [
                  _infoField(
                    imgPath: "location-pin.png",
                    title: "위치",
                    info: "서울특별시 종로구 혜화동 349-14번지",
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  _infoField(
                    imgPath: "hearts.png",
                    title: "아버지와의 추억",
                    info:
                        "진통이 정말 심했어요. 새벽에 아버지한테 제가 전화해서 너무 아프다고 울었어요. 그래서 그날 가족들 다같이 병원 으로 와서 진통하는 걸 봤었지요. 그때 아버지가 계속 손 잡고 옆에 지켜주셨어요. 둘째 낳고 아버지가 보양식이며 배냇저고리며 이거저거 엄청 챙겨주셨던 거 기억나요. 낳자마자 아버지가 손수 이름 지어주겠다고 사흘밤낮동안 고민하셨던 것도 눈에 선해요.",
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  RememberMeBox(
                    padding: EdgeInsets.symmetric(vertical: 10.5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/full-volume.png",
                          width: 0.1.sw,
                        ),
                        SizedBox(width: 11.0.w),
                        RememberMeText(
                          "가족의 목소리",
                          size: 14.sp,
                          letterSpacing: -0.28.sp,
                          color: const Color(0xFF535353),
                          weight: BOLD,
                        ),
                        const Spacer(),
                        RememberMeBox(
                          width: 27.w,
                          height: 27.w,
                          shape: BoxShape.circle,
                          color: const Color(0xFFE8EAFF),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Color(0xFF707070),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoField({
    required String imgPath,
    required String title,
    required String info,
  }) {
    return RememberMeBox(
      padding: EdgeInsets.symmetric(vertical: 10.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/$imgPath",
            width: 0.1.sw,
          ),
          SizedBox(width: 11.0.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RememberMeText(
                  title,
                  size: 14.sp,
                  letterSpacing: -0.28.sp,
                  color: const Color(0xFF535353),
                  weight: BOLD,
                ),
                SizedBox(height: 4.5.h),
                RememberMeText(
                  info,
                  size: 12.sp,
                  letterSpacing: -0.24.sp,
                  color: const Color(0xFF535353),
                  weight: REGULAR,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _memoryImg() {
    return RememberMeBox(
      width: 1.0.sw,
      height: 1.0.sw,
      child: CachedNetworkImage(
        imageUrl: widget.imgUrl,
        fit: BoxFit.cover,
        color: Colors.black26,
        colorBlendMode: BlendMode.darken,
      ),
    );
  }

  Widget _dateAndTitle() {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      child: RememberMeBox(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RememberMeText(
              "2001. 10. 20",
              size: 14.sp,
              weight: MEDIUM,
              color: WHITE,
              letterSpacing: -0.28.sp,
            ),
            Row(
              children: [
                RememberMeText(
                  "둘째손주 미애 탄생",
                  size: 36.sp,
                  weight: BOLD,
                  color: WHITE,
                  letterSpacing: -0.72.sp,
                ),
                SizedBox(width: 10.5.w),
                if (!widget.isFromPatient)
                  RememberMeBox(
                    color: WHITE,
                    padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 9.0.w),
                    borderRadius: BorderRadius.circular(17.0.r),
                    child: RememberMeText(
                      "수정",
                      size: 14.sp,
                      color: const Color(0xFF535353),
                      weight: BOLD,
                      letterSpacing: -0.28.sp,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
