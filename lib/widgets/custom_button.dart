import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/dismension.dart';
import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final Widget child;
  final double? opacity;
  final Color? shadowColor;

  const CustomButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.backgroundColor,
    this.width = double.infinity,
    this.height,
    this.gradient,
    this.opacity,
    this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        this.borderRadius ?? BorderRadius.circular(Sizes.radiusLgSize);
    final height = this.height ?? 5.h;
    final gradient = this.gradient ??
        (backgroundColor == null
            ? LinearGradient(
                colors: [
                  ColorPalette.primaryColor.withOpacity(opacity ?? 1),
                  ColorPalette.secondaryColor.withOpacity(opacity ?? 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null);
    final shadowColor = this.shadowColor ??
        (backgroundColor ??
            ColorPalette.secondaryColor.withOpacity(opacity ?? 1));
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        color:
            (gradient == null) ? backgroundColor ?? Colors.transparent : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? Colors.transparent,
          shadowColor: shadowColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
