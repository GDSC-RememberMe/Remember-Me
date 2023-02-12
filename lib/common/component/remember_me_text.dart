import 'package:flutter/material.dart';
import 'package:remember_me_mobile/common/const/colors.dart';
import 'package:remember_me_mobile/common/const/fonts.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';

class RememberMeText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final double letterSpacing;
  final String? fontFamily;
  final TextOverflow overflow;
  final TextAlign align;
  final bool selectable;
  final TextDecoration? textDecoration;

  const RememberMeText(
    this.text, {
    Key? key,
    this.size = 14,
    this.weight = FontWeight.w500,
    this.color = GREY900,
    this.letterSpacing = -0.8,
    this.fontFamily = NOTO_SANS,
    this.overflow = TextOverflow.visible,
    this.align = TextAlign.start,
    this.selectable = false,
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectable) {
      return SelectableAutoLinkText(
        text,
        style: TextStyle(
          fontWeight: weight,
          letterSpacing: letterSpacing,
          fontSize: size,
          color: color,
          fontFamily: fontFamily,
          overflow: overflow,
        ),
        textAlign: align,
      );
    } else {
      return Text(
        text,
        style: TextStyle(
            fontWeight: weight,
            letterSpacing: letterSpacing,
            fontSize: size,
            color: color,
            fontFamily: fontFamily,
            overflow: overflow,
            decoration: textDecoration),
        textAlign: align,
      );
    }
  }
}
