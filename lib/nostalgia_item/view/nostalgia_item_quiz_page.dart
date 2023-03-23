import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/common/component/remember_me_box.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';
import 'package:remember_me_mobile/nostalgia_item/model/nostalgia_item_model.dart';
import 'package:remember_me_mobile/nostalgia_item/provider/nostalgia_item_provider.dart';

class NostalgiaItemQuizPage extends ConsumerStatefulWidget {
  const NostalgiaItemQuizPage({super.key});

  static String get routeName => "nostalgia_item_quiz";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NostalgiaItemQuizPageState();
}

class _NostalgiaItemQuizPageState extends ConsumerState<NostalgiaItemQuizPage> {
  int _currentIdx = 0;
  List<Map<NostalgiaItemModel, Map<String, bool>>> _selectedAnswers = [];
  Map<NostalgiaItemModel, Map<String, bool>>? _selectedAnswer;
  bool _isAnswered = false;

  List<Map<NostalgiaItemModel, Map<String, bool>>> answers = [];

  bool _isLoading = false;

  bool _visible = false;

  int _answerCount = 0;

  final TextStyle baseTextStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: REGULAR,
    color: const Color(0xFF4A4A4A),
  );

  @override
  void initState() {
    super.initState();
    final items = ref.read(nostalgiaItemProvider);
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(nostalgiaItemProvider);
    if (items.isEmpty) {
      return Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ));
    }

    return RememberMeAppBarLayout(
      appBarTitle: "추억의 물건 게임",
      isNeedBackButton: true,
      body: _visible
          ? AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 0),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/star.png",
                        width: 0.5.sw,
                      ),
                      SizedBox(height: 35.0.h),
                      RememberMeText(
                        "와우! 수고하셨어요.",
                        size: 30.sp,
                        weight: MEDIUM,
                        color: const Color(0xFF4A4A4A),
                        letterSpacing: -1.2.sp,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "5문제 ",
                              style: baseTextStyle.copyWith(
                                fontWeight: BOLD,
                              ),
                            ),
                            TextSpan(
                              text: "중 총 ",
                              style: baseTextStyle,
                            ),
                            TextSpan(
                              text: "$_answerCount문제 ",
                              style: baseTextStyle.copyWith(
                                fontWeight: BOLD,
                                color: const Color(0xFF910404),
                              ),
                            ),
                            TextSpan(
                              text: "맞추셨습니다.",
                              style: baseTextStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _submitButton(
                            onTap: () {
                              context.pop();
                            },
                            title: "홈으로 가기",
                            color: const Color(0xFFFAF5F5),
                          ),
                          SizedBox(width: 27.0.w),
                          _submitButton(
                            onTap: () async {},
                            title: "오답 확인하기",
                            color: WHITE,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : RememberMeBox(
              padding: EdgeInsets.symmetric(vertical: 30.0.h),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: items[_currentIdx].imgUrl,
                        width: 0.5.sw,
                        color: WHITE.withOpacity(0.24),
                        colorBlendMode: BlendMode.lighten,
                        placeholder: (context, url) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.0.h),
                      Image.asset(
                        "assets/images/question-mark.png",
                        height: 0.15.sw,
                      ),
                      SizedBox(height: 10.0.h),
                      RememberMeText(
                        "위 사진 속 물건의 이름은 무엇일까요?",
                        size: 17.sp,
                        weight: BOLD,
                        color: const Color(0xFF4A4A4A),
                        letterSpacing: -0.68.sp,
                      ),
                      SizedBox(height: 35.0.h),
                      Stack(
                        children: [
                          Consumer(builder: (context, ref, widget) {
                            answers = [
                              {
                                items[_currentIdx]: {
                                  items[_currentIdx].rightAnswer: true,
                                },
                              },
                              {
                                items[_currentIdx]: {
                                  items[_currentIdx].wrongAnswer: false,
                                },
                              }
                            ]..shuffle();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: answers.map((answer) {
                                return _answerButton(answer: answer);
                              }).toList(),
                            );
                          }),
                          Visibility(
                            visible: _selectedAnswer != null,
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                _isAnswered ? Icons.circle_outlined : Icons.close,
                                color: _isAnswered ? const Color(0xFF02A835) : const Color(0xFFDE0000),
                                size: 0.5.sw,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _whenButtonTapped({
    required Map<NostalgiaItemModel, Map<String, bool>> answer,
  }) async {
    setState(() {
      _isLoading = true;
      _selectedAnswer = answer;
      if (answer.entries.first.value.containsValue(true)) {
        _isAnswered = true;
      } else {
        _isAnswered = false;
      }
      _selectedAnswers.add(answer);
    });
    Future.delayed(
      const Duration(milliseconds: 300),
    ).then((_) {
      setState(() {
        _selectedAnswer = null;
        _isAnswered = false;
        _isLoading = false;
        if (_currentIdx < 4) {
          _currentIdx++;
        }
      });
    });

    if (_currentIdx == 4) {
      final status =
          await ref.read(nostalgiaItemProvider.notifier).saveNostalgiaItemResult(selectedAnswers: _selectedAnswers);
      if (status) {
        for (Map<NostalgiaItemModel, Map<String, bool>> answer in _selectedAnswers) {
          if (answer.entries.first.value.entries.first.value) {
            _answerCount++;
          }
        }
        setState(() {
          _visible = true;
        });
      }
    }
  }

  Widget _submitButton({
    required VoidCallback onTap,
    required String title,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: RememberMeBox(
        child: RememberMeBox(
          color: color,
          borderColor: const Color(0xFF707070),
          borderWidth: 0.7.w,
          borderRadius: BorderRadius.circular(11.0.r),
          padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.0.h),
          child: RememberMeText(
            title,
            size: 13.sp,
            weight: BOLD,
            color: const Color(0xFF707070),
            letterSpacing: -0.26.sp,
          ),
        ),
      ),
    );
  }

  Widget _answerButton({
    required Map<NostalgiaItemModel, Map<String, bool>> answer,
  }) {
    return Builder(builder: (context) {
      MapEntry<String, bool> answerEntry = answer.entries.first.value.entries.first;
      return GestureDetector(
        onTap: () {
          if (!_isLoading) {
            _whenButtonTapped(answer: answer);
          }
        },
        child: RememberMeBox(
          width: 100.0.w,
          height: 100.0.w,
          margin: EdgeInsets.only(right: 24.0.w),
          borderRadius: BorderRadius.circular(18.0.r),
          borderColor: const Color(0xFFD0D0D0),
          borderWidth: 0.7.w,
          color: _selectedAnswer == answer ? const Color(0xFFF8E8FB) : WHITE,
          child: Center(
            child: RememberMeText(
              answerEntry.key,
              size: 16.sp,
              weight: BOLD,
              color: const Color(0xFF707070),
              letterSpacing: -0.64.sp,
            ),
          ),
        ),
      );
    });
  }
}
