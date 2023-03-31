import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:remember_me_mobile/common/component/remember_me_text.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/text.dart';

class RememberMeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RememberMeAppBar({
    super.key,
    required this.title,
    this.isNeedBackButton = true,
    this.onPressed,
  });

  final String title;
  final bool isNeedBackButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0.0,
      elevation: 2.0,
      backgroundColor: WHITE,
      leading: isNeedBackButton
          ? IconButton(
              onPressed: onPressed ??
                  () {
                    context.pop();
                  },
              icon: const Icon(Icons.arrow_back_ios),
              color: const Color(0xFF707070),
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              disabledColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
          : const SizedBox.shrink(),
      title: RememberMeText(
        title,
        size: 20.sp,
        weight: BOLD,
        letterSpacing: -0.4.sp,
        color: const Color(0xFF707070),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_rounded),
          color: const Color(0xFF707070),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          disabledColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
      iconTheme: const IconThemeData(
        color: Color(0xFF707070),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
