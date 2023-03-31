import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:remember_me_mobile/common/component/birth_date_picker.dart';
import 'package:remember_me_mobile/common/component/onboarding_text_form_field.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/user/component/sign_up_text_form_field.dart';

final onBoardingThirdPageViewIdxProvider = StateProvider<int>(
  (ref) => 0,
);

class OnBoardingFirstPageView extends StatelessWidget {
  const OnBoardingFirstPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: ONBOARDING_TEXT_STYLE,
            children: [
              TextSpan(
                text: "만나서 반가워요.\n",
                style: ONBOARDING_TEXT_STYLE,
              ),
              TextSpan(
                text: "치매가족의 삶의 질을 올려 줄 서비스,\n",
                style: ONBOARDING_TEXT_STYLE,
              ),
              TextSpan(
                text: "리멤버미 ",
                style: ONBOARDING_TEXT_STYLE.copyWith(fontWeight: BOLD),
              ),
              TextSpan(
                text: "입니다.",
                style: ONBOARDING_TEXT_STYLE,
              ),
            ],
          ),
        ),
        Center(
          child: Image.asset(
            "assets/images/fist-bump-gesture.png",
            width: 0.8.sw,
          ),
        ),
      ],
    );
  }
}

class OnBoardingSecondPageView extends StatelessWidget {
  OnBoardingSecondPageView({
    super.key,
  });

  final List<String> _reasons = [
    "소통의 부재",
    "기억력 저하",
    "환자에 대한 죄책감",
    "위급한 상황에 대한 긴장과 불안",
    "환자 상태체크에 대한 어려움",
    "치매 진척도 체크에 대한 어려움",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: ONBOARDING_TEXT_STYLE,
            text: "치매환자를 돌볼 때,\n",
            children: [
              TextSpan(
                text: "어떤 점이 가장 힘드신가요?\n",
                style: ONBOARDING_TEXT_STYLE.copyWith(
                  fontWeight: BOLD,
                ),
              ),
              TextSpan(
                text: "리멤버미에서 관리해 드릴게요.",
                style: ONBOARDING_TEXT_STYLE,
              ),
            ],
          ),
        ),
        SizedBox(height: 56.0.h),
        ..._reasons.map((reason) {
          return _textChip(text: reason, context: context);
        }).toList(),
      ],
    );
  }

  Widget _textChip({required String text, required BuildContext context}) {
    return RememberMeBox(
      margin: EdgeInsets.only(bottom: 16.0.h),
      child: Chip(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.0.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 22.5.w, vertical: 12.5.h),
        label: RememberMeText(
          text,
          size: 16.sp,
          weight: BOLD,
          color: WHITE,
          letterSpacing: -0.8.sp,
        ),
      ),
    );
  }
}

class OnBoardingThirdPageView extends ConsumerStatefulWidget {
  const OnBoardingThirdPageView({
    super.key,
  });

  @override
  OnBoardingThirdPageViewState createState() => OnBoardingThirdPageViewState();
}

class OnBoardingThirdPageViewState extends ConsumerState<OnBoardingThirdPageView> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController address1Ctrl = TextEditingController();
  final TextEditingController address2Ctrl = TextEditingController();

  Map<String, bool> gender = {
    "남성": false,
    "여성": false,
  };

  Map<String, bool> grade = {
    "1급": false,
    "2급": false,
    "3급": false,
    "4급": false,
    "5급": false,
    "급수 없음": false,
  };

  DateTime _birthDate = DateFormat('yyyy-MM-dd').parse("1950-01-01");

  @override
  Widget build(BuildContext context) {
    return _buildThirdView();
  }

  Widget _buildThirdView() {
    switch (ref.watch(onBoardingThirdPageViewIdxProvider)) {
      case 0:
        return _firstIdxView();
      case 1:
        return _secondIdxView();
      case 2:
        return _thirdIdxView();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _firstIdxView() {
    return RememberMeBox(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      margin: EdgeInsets.only(bottom: 70.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RememberMeText(
            "환자 정보를 입력해 볼까요?",
            size: 21.sp,
            weight: MEDIUM,
            letterSpacing: -1.05.sp,
            color: const Color(0xFF707070),
          ),
          SizedBox(height: 24.h),
          RememberMeText(
            "이름",
            size: 12.sp,
            weight: BOLD,
            letterSpacing: -0.48.sp,
            color: const Color(0xFF525252),
          ),
          SizedBox(height: 10.0.h),
          OnBoardingTextFormField(
            ctrl: nameCtrl,
            hintText: "홍길동",
          ),
          SizedBox(height: 30.0.h),
          RememberMeText(
            "생년월일",
            size: 12.sp,
            weight: BOLD,
            letterSpacing: -0.48.sp,
            color: const Color(0xFF525252),
          ),
          SizedBox(height: 10.0.h),
          BirthDatePicker(
            onDateTimeChanged: (DateTime dt) {
              setState(() {
                _birthDate = dt;
              });
            },
          ),
          SizedBox(height: 30.0.h),
          RememberMeText(
            "성별",
            size: 12.sp,
            weight: BOLD,
            letterSpacing: -0.48.sp,
            color: const Color(0xFF525252),
          ),
          SizedBox(height: 10.0.h),
          Center(
            child: Wrap(
              children: gender.entries.map((entry) {
                return _infoActionChip(
                  mapValue: gender,
                  entry: entry,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 30.0.h),
          RememberMeText(
            "치매 급수",
            size: 12.sp,
            weight: BOLD,
            letterSpacing: -0.48.sp,
            color: const Color(0xFF525252),
          ),
          SizedBox(height: 10.0.h),
          Center(
            child: Wrap(
              children: grade.entries.map((entry) {
                return _infoActionChip(
                  mapValue: grade,
                  entry: entry,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 30.0.h),
          RememberMeText(
            "전화번호",
            size: 12.sp,
            weight: BOLD,
            letterSpacing: -0.48.sp,
            color: const Color(0xFF525252),
          ),
          SizedBox(height: 10.0.h),
          OnBoardingTextFormField(
            ctrl: phoneCtrl,
            hintText: "01012345678",
          ),
          SizedBox(height: 30.0.h),
          RememberMeText(
            "주소",
            size: 12.sp,
            weight: BOLD,
            letterSpacing: -0.48.sp,
            color: const Color(0xFF525252),
          ),
          SizedBox(height: 10.0.h),
          GestureDetector(
            onTap: () async {
              KopoModel model = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => RemediKopo(),
                ),
              );
              if (model.address != null) {
                setState(() {
                  address1Ctrl.text = model.address as String;
                });
              }
            },
            child: RememberMeBox(
              borderRadius: BorderRadius.circular(4.0.r),
              padding: EdgeInsets.all(8.0.r),
              color: const Color(0xFFEEEEEE),
              child: Row(
                children: [
                  RememberMeText(
                    "지번, 도로명, 건물명으로 검색하기",
                    size: 10.sp,
                    weight: BOLD,
                    letterSpacing: -0.4.sp,
                    color: const Color(0xFFA5A5A5),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.search,
                    color: const Color(0xFF707070),
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18.0.h),
          SignUpTextFormField(
            readOnly: true,
            ctrl: address1Ctrl,
            hintText: "지번, 도로명, 건물명",
          ),
          SizedBox(height: 18.0.h),
          SignUpTextFormField(
            ctrl: address2Ctrl,
            hintText: "상세주소 입력",
          ),
        ],
      ),
    );
  }

  Widget _infoActionChip({
    required Map<String, bool> mapValue,
    required MapEntry<String, bool> entry,
  }) {
    return RememberMeBox(
      margin: EdgeInsets.only(right: 15.0.w),
      child: ActionChip(
        padding: EdgeInsets.all(8.0.r),
        label: RememberMeText(
          entry.key,
          size: 10.sp,
          color: entry.value ? Theme.of(context).colorScheme.primary : const Color(0xFFA5A5A5),
          weight: BOLD,
          letterSpacing: -0.4.sp,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: entry.value ? Theme.of(context).colorScheme.primary : const Color(0xFFAAAAAA),
            width: 1.0.w,
          ),
          borderRadius: BorderRadius.circular(5.0.r),
        ),
        backgroundColor: WHITE,
        onPressed: () {
          setState(() {
            if (mapValue[entry.key] != true && mapValue.containsValue(true)) {
              mapValue.forEach((key, value) {
                mapValue[key] = false;
              });
            }
            mapValue[entry.key] = !mapValue[entry.key]!;
          });
        },
      ),
    );
  }

  Widget _secondIdxView() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RememberMeText(
              "환자 사진을 등록해 주세요.",
              size: 21.sp,
              weight: MEDIUM,
              letterSpacing: -1.05.sp,
              color: const Color(0xFF707070),
            ),
            SizedBox(height: 40.0.h),
            GestureDetector(
              onTap: () {
                // TODO Picker로 사진 등록하기.
              },
              child: Center(
                child: Stack(
                  children: [
                    RememberMeBox(
                      width: 140.0.w,
                      height: 140.0.w,
                      color: const Color(0xFFD5D5D5),
                      shape: BoxShape.circle,
                      child: Center(
                        child: Icon(
                          Icons.person_rounded,
                          size: 108.w,
                          color: WHITE,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6.0,
                      bottom: 6.0,
                      child: RememberMeBox(
                        width: 30.0.w,
                        height: 30.0.w,
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 24.w,
                            color: WHITE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _thirdIdxView() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RememberMeText(
              "환자와 관련된 사진을 등록해 주세요.",
              size: 21.sp,
              weight: MEDIUM,
              letterSpacing: -1.05.sp,
              color: const Color(0xFF707070),
            ),
            SizedBox(height: 40.0.h),
            GestureDetector(
              onTap: () {
                // TODO Picker로 사진 등록하기.
              },
              child: Center(
                child: Stack(
                  children: [
                    RememberMeBox(
                      child: Icon(
                        Icons.photo_rounded,
                        size: 140.0.w,
                        color: const Color(0xFFD5D5D5),
                      ),
                    ),
                    Positioned(
                      right: 6.0,
                      bottom: 6.0,
                      child: RememberMeBox(
                        width: 30.0.w,
                        height: 30.0.w,
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 24.w,
                            color: WHITE,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingFourthPageView extends StatefulWidget {
  const OnBoardingFourthPageView({super.key});

  @override
  State<OnBoardingFourthPageView> createState() => _OnBoardingFourthPageViewState();
}

class _OnBoardingFourthPageViewState extends State<OnBoardingFourthPageView> {
  Map<int, bool> time = {
    1: false,
    2: false,
    3: false,
    4: false,
  };

  @override
  Widget build(BuildContext context) {
    return RememberMeBox(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      margin: EdgeInsets.only(bottom: 70.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RememberMeText(
            "추억을 가져다 드릴\n하루 푸시알림 횟수를 선택해 주세요.",
            size: 21.sp,
            weight: MEDIUM,
            letterSpacing: -1.05.sp,
            color: const Color(0xFF707070),
          ),
          SizedBox(height: 55.0.h),
          Center(
              child: Column(
            children: time.entries.map((entry) {
              return _infoActionChip(
                mapValue: time,
                entry: entry,
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _infoActionChip({
    required Map<int, bool> mapValue,
    required MapEntry<int, bool> entry,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (mapValue[entry.key] != true && mapValue.containsValue(true)) {
            mapValue.forEach((key, value) {
              mapValue[key] = false;
            });
          }
          mapValue[entry.key] = !mapValue[entry.key]!;
        });
      },
      child: RememberMeBox(
        margin: EdgeInsets.only(bottom: 24.0.h),
        color: entry.value ? Theme.of(context).colorScheme.primary : const Color(0xFFE3BDF6),
        padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 71.0.w),
        borderRadius: BorderRadius.circular(17.0.r),
        child: RememberMeText(
          "${entry.key}번",
          size: 16.sp,
          color: WHITE,
          weight: BOLD,
          letterSpacing: -0.8.sp,
        ),
      ),
    );
  }
}
