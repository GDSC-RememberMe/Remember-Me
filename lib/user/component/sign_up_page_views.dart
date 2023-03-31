import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:remember_me_mobile/common/component/birth_date_picker.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/user/component/sign_up_text_form_field.dart';
import 'package:remember_me_mobile/user/model/term_model.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';
import 'package:remember_me_mobile/user/provider/current_user_provider.dart';
import 'package:remember_me_mobile/user/provider/sign_up_provider.dart';

class SignUpFirstPageView extends ConsumerStatefulWidget {
  const SignUpFirstPageView({super.key});

  @override
  ConsumerState<SignUpFirstPageView> createState() => _SignUpFirstPageViewState();
}

class _SignUpFirstPageViewState extends ConsumerState<SignUpFirstPageView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RememberMeText(
            "본인의 역할을 선택해 주세요",
            size: 16.sp,
            weight: BOLD,
            color: const Color(0xFF707070),
            letterSpacing: -0.8.sp,
          ),
          SizedBox(height: 25.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ref.watch(signUpProvider).roles.entries.map(
              (entry) {
                return roleChip(roleEntry: entry);
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget roleChip({required MapEntry<UserRole, bool> roleEntry}) {
    return GestureDetector(
      onTap: () {
        final roles = ref.read(signUpProvider).roles;
        setState(() {
          if (roles[roleEntry.key] != true && roles.containsValue(true)) {
            roles.forEach((key, value) {
              roles[key] = false;
            });
          }
          roles[roleEntry.key] = !roleEntry.value;
        });
      },
      child: RememberMeBox(
        width: 105.w,
        height: 105.w,
        borderColor:
            roleEntry.value ? Theme.of(context).colorScheme.primary.withOpacity(0.57) : const Color(0xFFD0D0D0),
        color: roleEntry.value ? Theme.of(context).colorScheme.primary.withOpacity(0.57) : WHITE,
        borderRadius: BorderRadius.circular(18.0.r),
        margin: EdgeInsets.symmetric(horizontal: 12.0.w),
        child: Center(
          child: RememberMeText(
            roleEntry.key == UserRole.patient ? "환자" : "보호자",
            size: 16.sp,
            weight: BOLD,
            color: roleEntry.value ? WHITE : const Color(0xFF707070),
            letterSpacing: -0.8.sp,
          ),
        ),
      ),
    );
  }
}

class SignUpSecondPageView extends ConsumerStatefulWidget {
  const SignUpSecondPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpSecondPageViewState();
}

class _SignUpSecondPageViewState extends ConsumerState<SignUpSecondPageView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RememberMeText(
          "약관에 동의해 주세요.",
          size: 16.sp,
          weight: BOLD,
          color: const Color(0xFF707070),
          letterSpacing: -0.8.sp,
        ),
        SizedBox(height: 20.0.h),
        RememberMeBox(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 21.0.w, vertical: 18.0.h),
          borderRadius: BorderRadius.circular(18.0.r),
          borderColor: const Color(0xFFD0D0D0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  final signUpData = ref.read(signUpProvider);
                  setState(() {
                    signUpData.terms = signUpData.terms.map((term) => term.copyWith(isAgreed: !term.isAgreed)).toList();
                  });
                  print(ref.read(signUpProvider).terms[0].isAgreed);
                  print(ref.read(signUpProvider).terms[1].isAgreed);
                  print(ref.read(signUpProvider).terms[2].isAgreed);
                },
                child: Row(
                  children: [
                    RememberMeBox(
                      width: 20.w,
                      height: 20.w,
                      color: ref.read(signUpProvider).terms.every((term) => term.isAgreed)
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFF707070).withOpacity(0.63),
                      shape: BoxShape.circle,
                      child: Icon(
                        Icons.check,
                        color: WHITE,
                        size: 12.sp,
                      ),
                    ),
                    SizedBox(width: 12.0.w),
                    RememberMeText(
                      "약관 전체동의",
                      size: 14.sp,
                      weight: BOLD,
                      color: const Color(0xFF707070),
                      letterSpacing: -0.56.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.0.h),
              const Divider(color: Color(0xFFA0A0A0)),
              SizedBox(height: 14.0.h),
              ...ref
                  .read(signUpProvider)
                  .terms
                  .map(
                    (term) => _termsCheckBox(term: term),
                  )
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _termsCheckBox({required TermModel term}) {
    return RememberMeBox(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              int _termIdx = ref.read(signUpProvider).terms.indexWhere((item) => item.title == term.title);
              setState(() {
                if (_termIdx != -1) ref.read(signUpProvider).terms[_termIdx] = term.copyWith(isAgreed: !term.isAgreed);
              });
              print(ref.read(signUpProvider).terms[0].isAgreed);
              print(ref.read(signUpProvider).terms[1].isAgreed);
              print(ref.read(signUpProvider).terms[2].isAgreed);
            },
            child: Row(
              children: [
                RememberMeBox(
                  width: 20.w,
                  height: 20.w,
                  borderColor:
                      term.isAgreed ? Theme.of(context).colorScheme.primary : const Color(0xFF707070).withOpacity(0.63),
                  shape: BoxShape.circle,
                  child: Icon(
                    Icons.check,
                    color: term.isAgreed
                        ? Theme.of(context).colorScheme.primary
                        : const Color(0xFF707070).withOpacity(0.63),
                    size: 12.sp,
                  ),
                ),
                SizedBox(width: 6.0.w),
                RememberMeText(
                  "[${term.termRole == TermRole.essential ? "필수" : "선택"}] ${term.title}",
                  size: 12.sp,
                  weight: MEDIUM,
                  color: const Color(0xFF707070),
                  letterSpacing: -0.48.sp,
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              // TODO 약관 보기
            },
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12.sp,
              color: const Color(0xFFCCCCCC),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpThirdPageView extends ConsumerStatefulWidget {
  const SignUpThirdPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpThirdPageViewState();
}

class _SignUpThirdPageViewState extends ConsumerState<SignUpThirdPageView> {
  late SignUpNotifier signUpData;

  @override
  void initState() {
    signUpData = ref.read(signUpProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RememberMeBox(
          padding: EdgeInsets.symmetric(horizontal: 17.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RememberMeText(
                "기본 정보를 입력해 주세요.",
                size: 16.sp,
                letterSpacing: -0.8.sp,
                weight: BOLD,
                color: const Color(0xFF707070),
              ),
              SizedBox(height: 23.h),
              RememberMeText(
                "아이디",
                size: 12.sp,
                letterSpacing: -0.48.sp,
                weight: BOLD,
              ),
              Row(
                children: [
                  SignUpTextFormField(
                    ctrl: signUpData.idCtrl,
                    hintText: "아이디를 입력해 주세요.",
                    constraints: BoxConstraints(maxWidth: 0.45.sw),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () async {
                      final bool status = await ref.read(currentUserNotifierProvider.notifier).joinValidation(
                            path: "username",
                            username: signUpData.idCtrl.text,
                          );

                      signUpData.idCheck = status;

                      Fluttertoast.showToast(
                        msg: status ? "사용 가능한 아이디입니다." : "이미 사용중인 아이디입니다.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        textColor: WHITE,
                        fontSize: 16.0.sp,
                      );
                    },
                    child: RememberMeBox(
                      padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.w),
                      borderColor: const Color(0xFFA5A5A5),
                      borderWidth: 0.7.w,
                      borderRadius: BorderRadius.circular(11.0.w),
                      child: RememberMeText(
                        "중복확인",
                        size: 9.sp,
                        letterSpacing: -0.32.sp,
                        color: const Color(0xFFA5A5A5),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              RememberMeText(
                "비밀번호",
                size: 12.sp,
                letterSpacing: -0.48.sp,
                weight: BOLD,
              ),
              SignUpTextFormField(
                ctrl: signUpData.passwordCtrl,
                hintText: "비밀번호를 입력해 주세요.",
                obscureText: true,
              ),
              SignUpTextFormField(
                ctrl: signUpData.passwordConfirmCtrl,
                hintText: "비밀번호를 다시 입력해 주세요.",
                obscureText: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SignUpFourthPageView extends ConsumerStatefulWidget {
  const SignUpFourthPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFourthPageViewState();
}

class _SignUpFourthPageViewState extends ConsumerState<SignUpFourthPageView> {
  late SignUpNotifier signUpData;

  @override
  void initState() {
    signUpData = ref.read(signUpProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RememberMeBox(
      padding: EdgeInsets.symmetric(horizontal: 17.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RememberMeText(
            "본인 정보를 입력해 주세요.",
            size: 16.sp,
            letterSpacing: -0.8.sp,
            weight: BOLD,
            color: const Color(0xFF707070),
          ),
          SizedBox(height: 23.h),
          RememberMeText(
            "이름",
            size: 12.sp,
            letterSpacing: -0.48.sp,
            weight: BOLD,
          ),
          SizedBox(height: 10.0.h),
          SignUpTextFormField(
            ctrl: signUpData.nameCtrl,
            hintText: "홍길동",
          ),
          SizedBox(height: 34.h),
          RememberMeText(
            "생년월일",
            size: 12.sp,
            letterSpacing: -0.48.sp,
            weight: BOLD,
          ),
          SizedBox(height: 10.0.h),
          BirthDatePicker(
            onDateTimeChanged: (DateTime dt) {
              signUpData.birthDate = dt;
            },
          ),
          SizedBox(height: 34.h),
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
              children: signUpData.gender.entries.map((entry) {
                return _infoActionChip(
                  entry: entry,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 34.h),
          RememberMeText(
            "전화번호",
            size: 12.sp,
            weight: BOLD,
            letterSpacing: -0.48.sp,
            color: const Color(0xFF525252),
          ),
          SizedBox(height: 10.0.h),
          Row(
            children: [
              SignUpTextFormField(
                ctrl: signUpData.phoneCtrl,
                hintText: "01012345678",
                constraints: BoxConstraints(maxWidth: 0.45.sw),
              ),
              SizedBox(width: 6.0.w),
              GestureDetector(
                onTap: () async {
                  final bool status = await ref.read(currentUserNotifierProvider.notifier).joinValidation(
                        path: "phone",
                        phone: signUpData.phoneCtrl.text,
                      );

                  signUpData.phoneCheck = status;

                  Fluttertoast.showToast(
                    msg: status ? "사용 가능한 전화번호입니다." : "이미 사용중인 전화번호입니다.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    textColor: WHITE,
                    fontSize: 16.0.sp,
                  );
                },
                child: RememberMeBox(
                  padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.w),
                  borderColor: const Color(0xFFA5A5A5),
                  borderWidth: 0.7.w,
                  borderRadius: BorderRadius.circular(11.0.w),
                  child: RememberMeText(
                    "중복확인",
                    size: 9.sp,
                    letterSpacing: -0.32.sp,
                    color: const Color(0xFFA5A5A5),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 100.0.h),
        ],
      ),
    );
  }

  Widget _infoActionChip({
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
            final gender = ref.read(signUpProvider).gender;
            if (gender[entry.key] != true && gender.containsValue(true)) {
              gender.forEach((key, value) {
                gender[key] = false;
              });
            }
            gender[entry.key] = !gender[entry.key]!;
          });
        },
      ),
    );
  }
}

class SignUpFifthPageView extends ConsumerStatefulWidget {
  const SignUpFifthPageView({super.key});

  @override
  ConsumerState<SignUpFifthPageView> createState() => _SignUpFifthPageViewState();
}

class _SignUpFifthPageViewState extends ConsumerState<SignUpFifthPageView> {
  late SignUpNotifier signUpData;

  @override
  void initState() {
    signUpData = ref.read(signUpProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RememberMeText(
          "본인 정보를 입력해 주세요.",
          size: 16.sp,
          letterSpacing: -0.8.sp,
          weight: BOLD,
          color: const Color(0xFF707070),
        ),
        SizedBox(height: 23.h),
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
              signUpData.address1Ctrl.text = "${model.sido} ${model.sigungu}";
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
          ctrl: signUpData.address1Ctrl,
          hintText: "지번, 도로명, 건물명",
        ),
        SizedBox(height: 18.0.h),
        SignUpTextFormField(
          ctrl: signUpData.address2Ctrl,
          hintText: "상세주소 입력",
        ),
      ],
    );
  }
}

class SignUpSixthPageView extends ConsumerStatefulWidget {
  const SignUpSixthPageView({super.key});

  @override
  ConsumerState<SignUpSixthPageView> createState() => _SignUpSixthPageViewState();
}

class _SignUpSixthPageViewState extends ConsumerState<SignUpSixthPageView> {
  final ImagePicker _picker = ImagePicker();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RememberMeText(
              "프로필을 설정해 주세요.",
              size: 21.sp,
              weight: MEDIUM,
              letterSpacing: -1.05.sp,
              color: const Color(0xFF707070),
            ),
            SizedBox(height: 40.0.h),
            GestureDetector(
              onTap: () async {
                XFile? img = await _picker.pickImage(source: ImageSource.gallery);

                setState(() {
                  image = img;
                });

                ref.watch(signUpProvider).profileImage = image;

                print(ref.watch(signUpProvider).profileImage);
              },
              child: Center(
                child: Stack(
                  children: [
                    image != null
                        ? Container(
                            width: 140.0.w,
                            height: 140.0.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  File(image!.path),
                                ),
                              ),
                            ),
                          )
                        : RememberMeBox(
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
}
