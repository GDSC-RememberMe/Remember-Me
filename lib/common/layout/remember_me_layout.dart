import 'package:flutter/material.dart';
import 'package:remember_me_mobile/common/const/colors.dart';

class RememberMeLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const RememberMeLayout({
    Key? key,
    required this.body,
    this.backgroundColor,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
    this.bottomSheet,
    this.floatingActionButtonLocation,
    this.extendBody,
    this.extendBodyBehindAppBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? WHITE,
      appBar: appBar,
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
