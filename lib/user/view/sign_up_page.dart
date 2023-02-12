import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/fonts.dart';
import 'package:remember_me_mobile/common/layout/default_layout.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: WHITE,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xFFBABABA),
            width: 0.5.r,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFBABABA),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 23.0,
              horizontal: 28.0,
            ).r,
            children: [
              Stack(
                children: [
                  UnconstrainedBox(
                    alignment: Alignment.centerLeft,
                    child: RememberMeBox(
                      margin: const EdgeInsets.symmetric(vertical: 3.0).r,
                      color: const Color(0xFFBABABA).withOpacity(0.25),
                      padding: const EdgeInsets.symmetric(vertical: 3.0).r,
                      borderRadius: BorderRadius.circular(13.0).w,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RememberMeBox(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ).r,
                            child: RememberMeText(
                              "1",
                              size: 16.sp,
                              letterSpacing: -0.8.sp,
                              weight: BOLD,
                              color: Colors.transparent,
                            ),
                          ),
                          RememberMeBox(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ).r,
                            child: RememberMeText(
                              "2",
                              size: 16.sp,
                              letterSpacing: -0.8.sp,
                              weight: BOLD,
                              color: Colors.transparent,
                            ),
                          ),
                          RememberMeBox(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ).r,
                            child: RememberMeText(
                              "3",
                              size: 16.sp,
                              letterSpacing: -0.8.sp,
                              weight: BOLD,
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: UnconstrainedBox(
                      alignment: Alignment.centerLeft,
                      child: RememberMeBox(
                        borderRadius: BorderRadius.circular(13.0).w,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RememberMeBox(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 12.0,
                              ).r,
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              child: RememberMeText(
                                "1",
                                size: 16.sp,
                                letterSpacing: -0.8.sp,
                                weight: BOLD,
                                color: const Color(0xFF707070),
                              ),
                            ),
                            RememberMeBox(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 12.0,
                              ).r,
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                              child: RememberMeText(
                                "2",
                                size: 16.sp,
                                letterSpacing: -0.8.sp,
                                weight: BOLD,
                                color: WHITE,
                              ),
                            ),
                            RememberMeBox(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 12.0,
                              ).r,
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              child: RememberMeText(
                                "3",
                                size: 16.sp,
                                letterSpacing: -0.8.sp,
                                weight: BOLD,
                                color: const Color(0xFF707070),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 41.r),
              RememberMeBox(
                padding: const EdgeInsets.symmetric(horizontal: 17.0).r,
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
                    SizedBox(height: 23.r),
                    RememberMeText(
                      "아이디",
                      size: 12.sp,
                      letterSpacing: -0.48.sp,
                      weight: BOLD,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
