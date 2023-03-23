import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:remember_me_mobile/common/component/remember_me_app_bar.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';
import 'package:remember_me_mobile/common/view/caregiver_main_tab_page.dart';
import 'package:remember_me_mobile/common/view/patient_main_tab_page.dart';
import 'package:remember_me_mobile/memory_bubble/provider/memory_provider.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
import 'package:remember_me_mobile/user/provider/current_user_provider.dart';

class MemoryBubbleDetailPage extends ConsumerStatefulWidget {
  static String get routeName => "memory_bubble_detail";

  final int memoryId;
  final bool isFromPatient;

  const MemoryBubbleDetailPage({
    super.key,
    required this.memoryId,
    required this.isFromPatient,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryBubbleDetailPageState();
}

class _MemoryBubbleDetailPageState extends ConsumerState<MemoryBubbleDetailPage> {
  @override
  void initState() {
    super.initState();
    ref.read(memoryProvider.notifier).getMemory(memoryId: widget.memoryId);
  }

  @override
  Widget build(BuildContext context) {
    final memory = ref.watch(memoryDetailProvider(widget.memoryId));
    return RememberMeAppBarLayout(
      appBarTitle: "추억 회상",
      isNeedBackButton: true,
      onPressed: () {
        final user = ref.read(currentUserNotifierProvider);
        if (user is UserModel) {
          context
              .goNamed(user.role == UserRole.caregiver ? CaregiverMainTabPage.routeName : PatientMainTabPage.routeName);
        }
      },
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            Stack(
              children: [
                _memoryImg(memory?.imgUrl ?? ""),
                _dateAndTitle(memory?.title ?? "", ""),
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
                    info: memory?.tagWhere ?? "",
                  ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  _infoField(
                    imgPath: "hearts.png",
                    title: "아버지와의 추억",
                    info: memory?.content ?? "",
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

  Widget _memoryImg(String imageUrl) {
    return RememberMeBox(
      width: 1.0.sw,
      height: 1.0.sw,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        color: Colors.black26,
        colorBlendMode: BlendMode.darken,
      ),
    );
  }

  Widget _dateAndTitle(String title, String date) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      child: RememberMeBox(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RememberMeText(
              date,
              size: 14.sp,
              weight: MEDIUM,
              color: WHITE,
              letterSpacing: -0.28.sp,
            ),
            Row(
              children: [
                RememberMeText(
                  title,
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
