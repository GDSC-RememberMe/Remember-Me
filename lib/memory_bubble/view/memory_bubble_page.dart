import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/common/component/remember_me_app_bar.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';
import 'package:remember_me_mobile/memory_bubble/model/memory_model.dart';
import 'package:remember_me_mobile/memory_bubble/provider/memory_provider.dart';
import 'package:remember_me_mobile/memory_bubble/view/memory_bubble_detail_page.dart';
import 'package:remember_me_mobile/memory_bubble/view/memory_edit_form_page.dart';

class MemoryBubblePage extends ConsumerStatefulWidget {
  const MemoryBubblePage({
    super.key,
    required this.isPatient,
  });
  final bool isPatient;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MemoryBubblePageState();
}

class _MemoryBubblePageState extends ConsumerState<MemoryBubblePage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final TextStyle baseTextFormFieldStyle = TextStyle(
    fontSize: 11.0.sp,
    fontWeight: BOLD,
    color: const Color(0xFF707070),
    letterSpacing: -0.22.sp,
  );

  final TextStyle baseRichTextStyle = TextStyle(
    fontSize: 17.0.sp,
    fontWeight: MEDIUM,
    color: const Color(0xFF707070),
    letterSpacing: -0.34.sp,
  );

  // List<String> images = [
  //   "https://blog.kakaocdn.net/dn/0ZR5w/btrESCSMaam/FPayu51S7ow7TklKnKwb1K/img.gif",
  //   "https://thumbs.gfycat.com/UnawareReflectingIggypops-size_restricted.gif",
  //   "https://blog.kakaocdn.net/dn/dYpxuW/btrH6Io40ah/Mp42ovGhVu8cfmKQFFsR90/img.gif",
  //   "http://file3.instiz.net/data/file3/2022/07/24/a/0/2/a029191e2974bbeea81929b724b87d73.gif",
  //   "https://mblogthumb-phinf.pstatic.net/MjAxOTEyMjRfMTIz/MDAxNTc3MTk3Mjk3Nzk3.-pS507AlXiJ_DEQPO3kLCZ4AtyWg3bmbh-UKqPrMfWYg.ksyTxfAg56o9eHZpoNEvHj7m7n9m4LFsiI7yzJzxfDEg.GIF.angela9009/IMG_7425.GIF?type=w800",
  //   "http://file3.instiz.net/data/cached_img/upload/2019/10/04/1/61b0079f721093fb190453b1d270b2d1_mp4.gif",
  //   "https://i.pinimg.com/originals/80/73/77/807377d55a168df51067d39a17ecd25b.gif",
  //   "https://thumbs.gfycat.com/CalmEvilBluegill-size_restricted.gif",
  //   "https://blog.kakaocdn.net/dn/Byi0Y/btrpzKscAFS/ovXbzy7IIo3x0chGl3L8z0/img.gif",
  //   "https://blog.kakaocdn.net/dn/lNdve/btqIrur5nBj/N4R1Q2wcBkWzoP0VWbSsOk/img.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/06/30/14/668a748f78af2a8bdbc2e83f0b7dcb02_mp4.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/04/30/22/2b1612a29db50cd1f762b8d796531846.gif",
  //   "https://1.bp.blogspot.com/-12TTSNTOy3w/X4cndZpI24I/AAAAAAAAAHo/5RAGY3N_t3wcjPj794XzuIKJD02pNPRRACLcBGAsYHQ/s750/img%2B%252811%2529.gif",
  //   "https://blog.kakaocdn.net/dn/0ZR5w/btrESCSMaam/FPayu51S7ow7TklKnKwb1K/img.gif",
  //   "https://thumbs.gfycat.com/UnawareReflectingIggypops-size_restricted.gif",
  //   "https://blog.kakaocdn.net/dn/dYpxuW/btrH6Io40ah/Mp42ovGhVu8cfmKQFFsR90/img.gif",
  //   "http://file3.instiz.net/data/file3/2022/07/24/a/0/2/a029191e2974bbeea81929b724b87d73.gif",
  //   "https://mblogthumb-phinf.pstatic.net/MjAxOTEyMjRfMTIz/MDAxNTc3MTk3Mjk3Nzk3.-pS507AlXiJ_DEQPO3kLCZ4AtyWg3bmbh-UKqPrMfWYg.ksyTxfAg56o9eHZpoNEvHj7m7n9m4LFsiI7yzJzxfDEg.GIF.angela9009/IMG_7425.GIF?type=w800",
  //   "http://file3.instiz.net/data/cached_img/upload/2019/10/04/1/61b0079f721093fb190453b1d270b2d1_mp4.gif",
  //   "https://i.pinimg.com/originals/80/73/77/807377d55a168df51067d39a17ecd25b.gif",
  //   "https://thumbs.gfycat.com/CalmEvilBluegill-size_restricted.gif",
  //   "https://blog.kakaocdn.net/dn/Byi0Y/btrpzKscAFS/ovXbzy7IIo3x0chGl3L8z0/img.gif",
  //   "https://blog.kakaocdn.net/dn/lNdve/btqIrur5nBj/N4R1Q2wcBkWzoP0VWbSsOk/img.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/06/30/14/668a748f78af2a8bdbc2e83f0b7dcb02_mp4.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/04/30/22/2b1612a29db50cd1f762b8d796531846.gif",
  //   "https://1.bp.blogspot.com/-12TTSNTOy3w/X4cndZpI24I/AAAAAAAAAHo/5RAGY3N_t3wcjPj794XzuIKJD02pNPRRACLcBGAsYHQ/s750/img%2B%252811%2529.gif",
  //   "http://file3.instiz.net/data/file3/2022/07/24/a/0/2/a029191e2974bbeea81929b724b87d73.gif",
  //   "https://mblogthumb-phinf.pstatic.net/MjAxOTEyMjRfMTIz/MDAxNTc3MTk3Mjk3Nzk3.-pS507AlXiJ_DEQPO3kLCZ4AtyWg3bmbh-UKqPrMfWYg.ksyTxfAg56o9eHZpoNEvHj7m7n9m4LFsiI7yzJzxfDEg.GIF.angela9009/IMG_7425.GIF?type=w800",
  //   "http://file3.instiz.net/data/cached_img/upload/2019/10/04/1/61b0079f721093fb190453b1d270b2d1_mp4.gif",
  //   "https://i.pinimg.com/originals/80/73/77/807377d55a168df51067d39a17ecd25b.gif",
  //   "https://thumbs.gfycat.com/CalmEvilBluegill-size_restricted.gif",
  //   "https://blog.kakaocdn.net/dn/Byi0Y/btrpzKscAFS/ovXbzy7IIo3x0chGl3L8z0/img.gif",
  //   "https://blog.kakaocdn.net/dn/lNdve/btqIrur5nBj/N4R1Q2wcBkWzoP0VWbSsOk/img.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/06/30/14/668a748f78af2a8bdbc2e83f0b7dcb02_mp4.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/04/30/22/2b1612a29db50cd1f762b8d796531846.gif",
  //   "https://1.bp.blogspot.com/-12TTSNTOy3w/X4cndZpI24I/AAAAAAAAAHo/5RAGY3N_t3wcjPj794XzuIKJD02pNPRRACLcBGAsYHQ/s750/img%2B%252811%2529.gif",
  //   "http://file3.instiz.net/data/file3/2022/07/24/a/0/2/a029191e2974bbeea81929b724b87d73.gif",
  //   "https://mblogthumb-phinf.pstatic.net/MjAxOTEyMjRfMTIz/MDAxNTc3MTk3Mjk3Nzk3.-pS507AlXiJ_DEQPO3kLCZ4AtyWg3bmbh-UKqPrMfWYg.ksyTxfAg56o9eHZpoNEvHj7m7n9m4LFsiI7yzJzxfDEg.GIF.angela9009/IMG_7425.GIF?type=w800",
  //   "http://file3.instiz.net/data/cached_img/upload/2019/10/04/1/61b0079f721093fb190453b1d270b2d1_mp4.gif",
  //   "https://i.pinimg.com/originals/80/73/77/807377d55a168df51067d39a17ecd25b.gif",
  //   "https://thumbs.gfycat.com/CalmEvilBluegill-size_restricted.gif",
  //   "https://blog.kakaocdn.net/dn/Byi0Y/btrpzKscAFS/ovXbzy7IIo3x0chGl3L8z0/img.gif",
  //   "https://blog.kakaocdn.net/dn/lNdve/btqIrur5nBj/N4R1Q2wcBkWzoP0VWbSsOk/img.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/06/30/14/668a748f78af2a8bdbc2e83f0b7dcb02_mp4.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/04/30/22/2b1612a29db50cd1f762b8d796531846.gif",
  //   "https://1.bp.blogspot.com/-12TTSNTOy3w/X4cndZpI24I/AAAAAAAAAHo/5RAGY3N_t3wcjPj794XzuIKJD02pNPRRACLcBGAsYHQ/s750/img%2B%252811%2529.gif",
  //   "http://file3.instiz.net/data/file3/2022/07/24/a/0/2/a029191e2974bbeea81929b724b87d73.gif",
  //   "https://mblogthumb-phinf.pstatic.net/MjAxOTEyMjRfMTIz/MDAxNTc3MTk3Mjk3Nzk3.-pS507AlXiJ_DEQPO3kLCZ4AtyWg3bmbh-UKqPrMfWYg.ksyTxfAg56o9eHZpoNEvHj7m7n9m4LFsiI7yzJzxfDEg.GIF.angela9009/IMG_7425.GIF?type=w800",
  //   "http://file3.instiz.net/data/cached_img/upload/2019/10/04/1/61b0079f721093fb190453b1d270b2d1_mp4.gif",
  //   "https://i.pinimg.com/originals/80/73/77/807377d55a168df51067d39a17ecd25b.gif",
  //   "https://thumbs.gfycat.com/CalmEvilBluegill-size_restricted.gif",
  //   "https://blog.kakaocdn.net/dn/Byi0Y/btrpzKscAFS/ovXbzy7IIo3x0chGl3L8z0/img.gif",
  //   "https://blog.kakaocdn.net/dn/lNdve/btqIrur5nBj/N4R1Q2wcBkWzoP0VWbSsOk/img.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/06/30/14/668a748f78af2a8bdbc2e83f0b7dcb02_mp4.gif",
  //   "http://file3.instiz.net/data/cached_img/upload/2020/04/30/22/2b1612a29db50cd1f762b8d796531846.gif",
  //   "https://1.bp.blogspot.com/-12TTSNTOy3w/X4cndZpI24I/AAAAAAAAAHo/5RAGY3N_t3wcjPj794XzuIKJD02pNPRRACLcBGAsYHQ/s750/img%2B%252811%2529.gif",
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      appBar: const RememberMeAppBar(
        title: "추억 회상",
        isNeedBackButton: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(builder: (context, constraints) {
          return ListView(
            children: [
              RememberMeBox(
                padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 30.0.h),
                child: Column(
                  children: [
                    // _searchTextFormField(),
                    // SizedBox(height: 25.0.h),
                    _description(),
                  ],
                ),
              ),
              SizedBox(height: 30.0.h),
              _MemoryBubbles(
                constraints: constraints,
                memories: ref.watch(memoryProvider),
                isFromPatient: widget.isPatient,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _description() {
    return RememberMeBox(
      padding: EdgeInsets.only(left: 8.0.w),
      child: Row(
        children: [
          Image.asset(
            "assets/images/favorite-folder.png",
            width: 0.1.sw,
          ),
          SizedBox(width: 20.0.w),
          RichText(
            text: TextSpan(
              style: baseRichTextStyle,
              children: [
                TextSpan(
                  text: "${widget.isPatient ? "가족들과" : "아버지와"}의\n",
                  style: baseRichTextStyle,
                ),
                TextSpan(
                  text: "소중한 추억",
                  style: baseRichTextStyle.copyWith(fontWeight: BOLD),
                ),
                TextSpan(
                  text: "을 떠올려 보세요",
                  style: baseRichTextStyle,
                ),
              ],
            ),
          ),
          const Spacer(),
          if (!widget.isPatient)
            GestureDetector(
              onTap: () {
                context.pushNamed(MemoryEditFormPage.routeName);
              },
              child: const Icon(Icons.add_rounded),
            ),
        ],
      ),
    );
  }

  Widget _searchTextFormField() {
    return TextFormField(
      controller: _searchCtrl,
      style: baseTextFormFieldStyle.copyWith(
        color: GREY900,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE6F1FF),
        contentPadding: EdgeInsets.symmetric(horizontal: 17.0.w, vertical: 8.0.h),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.7.w,
            color: const Color(
              0xFF484848,
            ),
          ),
          borderRadius: BorderRadius.circular(11.r),
        ),
        hintText: "찾고 싶은 추억을 검색해 보세요!",
        hintStyle: baseTextFormFieldStyle,
        suffixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFF696969),
        ),
      ),
    );
  }
}

class _MemoryBubbles extends StatelessWidget {
  const _MemoryBubbles({
    super.key,
    required this.memories,
    required this.constraints,
    required this.isFromPatient,
  });

  final List<MemoryModel> memories;
  final BoxConstraints constraints;
  final bool isFromPatient;

  @override
  Widget build(BuildContext context) {
    return RememberMeBox(
      color: const Color(0xFFF4F6FD),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(56.0.r),
        topRight: Radius.circular(56.0.r),
      ),
      height: constraints.maxHeight,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 10.0.w),
      child: GridView.custom(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverStairedGridDelegate(
          crossAxisSpacing: 2,
          mainAxisSpacing: 4,
          startCrossAxisDirectionReversed: true,
          pattern: const [
            StairedGridTile(0.5, 1),
            StairedGridTile(0.5, 1.5),
            StairedGridTile(0.3, 1),
            StairedGridTile(0.3, 1.5),
            StairedGridTile(0.4, 1.5),
            StairedGridTile(0.5, 1.5),
            StairedGridTile(0.4, 1),
            StairedGridTile(1.0, 10 / 4),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            return _bubble(memories[index], context);
          },
          childCount: memories.length,
        ),
      ),
    );
  }

  Widget _bubble(
    MemoryModel memory,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          MemoryBubbleDetailPage.routeName,
          params: {
            "memoryId": "${memory.memoryId}",
            // TODO id 바꾸기
            "isFromPatient": "$isFromPatient",
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
          image: memory.imgUrl != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    memory.imgUrl as String,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
