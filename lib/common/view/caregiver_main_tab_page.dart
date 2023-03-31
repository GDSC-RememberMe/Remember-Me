import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';
import 'package:remember_me_mobile/common/layout/remember_me_layout.dart';
import 'package:remember_me_mobile/home/view/caregiver_home_page.dart';

import 'package:remember_me_mobile/memory_bubble/view/memory_bubble_page.dart';
import 'package:remember_me_mobile/memory_check/view/caregiver_memory_check_page.dart';
import 'package:remember_me_mobile/setting/view/setting_page.dart';

class CaregiverMainTabPage extends ConsumerStatefulWidget {
  const CaregiverMainTabPage({super.key});

  static String get routeName => "caregiver_main_tab";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CaregiverMainTabPageState();
}

class _CaregiverMainTabPageState extends ConsumerState<CaregiverMainTabPage> with SingleTickerProviderStateMixin {
  late TabController tabCtrl;
  int index = 2;

  @override
  void initState() {
    super.initState();

    tabCtrl = TabController(initialIndex: index, length: 5, vsync: this);
    tabCtrl.addListener(tabListener);
  }

  @override
  void dispose() {
    tabCtrl.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = tabCtrl.index;
    });
  }

  List<BottomNavigationBarItem> tabs = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      activeIcon: Icon(Icons.favorite_rounded),
      label: "추억",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: "인지체크",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home_rounded),
      label: "홈",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people_outline),
      activeIcon: Icon(Icons.people),
      label: "커뮤니티",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: "설정",
    ),
  ];

  final baseLabelStyle = TextStyle(
    fontSize: 8.5.sp,
    letterSpacing: -0.17.sp,
    color: const Color(0xFF707070),
    fontWeight: BOLD,
  );

  @override
  Widget build(BuildContext context) {
    return RememberMeLayout(
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 21.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF727272).withOpacity(0.20),
                offset: const Offset(2, 3),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0.r),
            child: BottomNavigationBar(
              selectedItemColor: Theme.of(context).colorScheme.primary.withOpacity(0.72),
              unselectedItemColor: const Color(0xFF999999),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: baseLabelStyle,
              unselectedLabelStyle: baseLabelStyle,
              currentIndex: index,
              items: tabs,
              onTap: (index) async {
                tabCtrl.animateTo(index);
              },
              backgroundColor: WHITE,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabCtrl,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const MemoryBubblePage(isPatient: false),
          const CaregiverMemoryCheckPage(),
          CaregiverHomePage(
            tabCtrl: tabCtrl,
          ),
          Center(
            child: RememberMeText(
              "COMING\nSOON",
              align: TextAlign.center,
              size: 36.0.sp,
              weight: BOLD,
            ),
          ),
          SettingPage(),
        ],
      ),
    );
  }
}
