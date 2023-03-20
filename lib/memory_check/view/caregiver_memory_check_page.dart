import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remember_me_mobile/common/layout/remember_me_app_bar_layout.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';

class CaregiverMemoryCheckPage extends ConsumerStatefulWidget {
  const CaregiverMemoryCheckPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CaregiverMemoryCheckPageState();
}

class _CaregiverMemoryCheckPageState extends ConsumerState<CaregiverMemoryCheckPage> {
  @override
  Widget build(BuildContext context) {
    return RememberMeAppBarLayout(
      appBarTitle: "인지체크",
      body: ListView(
        children: [],
      ),
    );
  }
}
