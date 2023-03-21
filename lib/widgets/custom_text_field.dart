import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BorderRadius? borderRadius;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator? validator;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        this.borderRadius ?? BorderRadius.circular(Sizes.radiusSmSize);
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: Sizes.fontLgSize,
        color: ColorPalette.fontBlackColor,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: ColorPalette.primaryColor,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          fontSize: Sizes.fontLgSize,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: ColorPalette.fontGreyColor,
        border: UnderlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8.sp,
          vertical: 8.sp,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: TextStyle(
          color: ColorPalette.fontLightColor,
          fontSize: Sizes.fontMdSize,
        ),
        filled: true,
        fillColor: ColorPalette.whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: suffixIcon,
        suffixIconColor: ColorPalette.raisinBlackColor,
        errorStyle: TextStyle(
          fontSize: Sizes.fontMdSize,
          color: ColorPalette.errorColor,
        ),
      ),
    );
  }
}
