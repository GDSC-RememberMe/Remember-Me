import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:remember_me_mobile/user/model/term_model.dart';
import 'package:remember_me_mobile/user/model/user_model.dart';

final signUpProvider = ChangeNotifierProvider<SignUpNotifier>((ref) {
  return SignUpNotifier();
});

class SignUpNotifier extends ChangeNotifier {
  Map<UserRole, bool> roles = {
    UserRole.patient: false,
    UserRole.caregiver: false,
  };

  List<TermModel> terms = [
    TermModel(
      termRole: TermRole.essential,
      title: "Remember Me 회원 이용약관 동의",
    ),
    TermModel(
      termRole: TermRole.essential,
      title: "개인정보 처리방침 동의",
    ),
    TermModel(
      title: "이벤트 등 마케팅 정보 수신 동의",
    ),
  ];

  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController passwordConfirmCtrl = TextEditingController();

  DateTime birthDate = DateFormat('yyyy-MM-dd').parse("1950-01-01");

  Map<String, bool> gender = {
    "남성": false,
    "여성": false,
  };

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  final TextEditingController address1Ctrl = TextEditingController();
  final TextEditingController address2Ctrl = TextEditingController();

  XFile? profileImage;

  bool idCheck = false;
  bool phoneCheck = false;
}
