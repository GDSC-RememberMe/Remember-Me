import 'package:flutter/material.dart';
import 'package:remember_me_mobile/common/component/remember_me_app_bar.dart';
import 'package:remember_me_mobile/common/const/colors.dart';

class RememberMeAppBarLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget body;
  final String appBarTitle;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool isNeedBackButton;

  const RememberMeAppBarLayout({
    Key? key,
    required this.body,
    required this.appBarTitle,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    this.bottomSheet,
    this.floatingActionButtonLocation,
    this.extendBody,
    this.extendBodyBehindAppBar,
    this.isNeedBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? WHITE,
      appBar: RememberMeAppBar(title: appBarTitle, isNeedBackButton: isNeedBackButton),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      bottomSheet: bottomSheet,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBody: extendBody ?? false,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
    );
  }
}
