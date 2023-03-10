import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Widget prefixIcon;
  final BorderRadius? borderRadius;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.borderRadius,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? const BorderRadius.all(Radius.circular(12));
    return TextField(
      style: TextStyle(fontSize: Sizes.fontMdSize),
      decoration:
          InputDecoration(
            labelText: hintText,
            labelStyle: TextStyle(fontSize: Sizes.fontMdSize),
            prefixIcon: prefixIcon,
            prefixIconColor: ColorPalette.fontGrayColor,
            border: OutlineInputBorder(borderRadius: borderRadius),
            contentPadding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 8.sp),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0),
              borderRadius: borderRadius
            ),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(width: 0),
              borderRadius: borderRadius
            ),
            filled: true,
            fillColor: ColorPalette.whiteColor,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
    );
  }
}
