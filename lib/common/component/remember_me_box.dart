import 'package:flutter/material.dart';

class RememberMeBox extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final BoxShape? shape;

  const RememberMeBox({
    required this.child,
    Key? key,
    this.color,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.padding,
    this.margin,
    this.borderRadius,
    this.width,
    this.height,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = BoxDecoration(
      color: color,
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      borderRadius: borderRadius,
    );
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: shape != null ? decoration.copyWith(shape: shape) : decoration,
        child: child,
      ),
    );
  }
}
