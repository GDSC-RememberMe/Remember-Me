import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';
import 'package:remember_me_mobile/nostalgia_item/provider/nostalgia_item_book_provider.dart';

class NostalgiaItemBookPage extends ConsumerStatefulWidget {
  const NostalgiaItemBookPage({super.key});
  static String get routeName => "nostalgia_item_book";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NostalgiaItemBookPageState();
}

class _NostalgiaItemBookPageState extends ConsumerState<NostalgiaItemBookPage> {
  @override
  Widget build(BuildContext context) {
    final resp = ref.watch(nostalgiaItemBookProvider);

    return RememberMeAppBarLayout(
      appBarTitle: "추억의 물건 도감",
      isNeedBackButton: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 28.0.w,
          vertical: 34.0.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RememberMeBox(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0.w,
                  vertical: 6.0.h,
                ),
                color: const Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(19.0.r),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/hearts.png",
                      width: 0.1.sw,
                    ),
                    SizedBox(width: 10.0.w),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "아버님이 맞추신 ",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: REGULAR,
                              color: const Color(0xFF191919),
                              letterSpacing: -0.47.sp,
                            ),
                          ),
                          TextSpan(
                            text: "추억의 물건",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: BOLD,
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: -0.47.sp,
                            ),
                          ),
                          TextSpan(
                            text: "들이에요.\n다른 추억의 물건들도 궁금하지 않나요?",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: REGULAR,
                              color: const Color(0xFF191919),
                              letterSpacing: -0.47.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 19.0.h),
            if (resp.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                itemCount: resp.length + 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 2, //item 의 가로 1, 세로 2 의 비율
                  mainAxisSpacing: 10, //수평 Padding
                  crossAxisSpacing: 10, //수직 Padding
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index < resp.length) {
                    return Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: resp[index].imgUrl,
                          width: 0.23.sw,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        RememberMeBox(
                          width: 0.23.sw,
                          height: 0.23.sw,
                          shape: BoxShape.circle,
                          color: const Color(0xFFDBDBDB),
                          child: Icon(
                            Icons.lock_rounded,
                            color: WHITE,
                            size: 24.0.w,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
