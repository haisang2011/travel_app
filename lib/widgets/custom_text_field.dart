import 'package:flutter/material.dart';
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

      decoration:
          InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(fontSize: kDefaultFontSize),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: prefixIcon,
            ),
            prefixIconConstraints: const BoxConstraints(minHeight: 45, minWidth: 45),
            border: OutlineInputBorder(borderRadius: borderRadius),
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
            floatingLabelBehavior: FloatingLabelBehavior.never
          ),
    );
  }
}
