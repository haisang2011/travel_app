import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';

class CustomPhoneNumberField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final BorderRadius? borderRadius;

  const CustomPhoneNumberField(
      {Key? key, this.hintText, this.borderRadius, this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        this.borderRadius ?? BorderRadius.circular(Sizes.radiusSmSize);
    return TextFormField(
      inputFormatters: [
        PhoneInputFormatter(
          allowEndlessPhone: false,
        )
      ],
      keyboardType: TextInputType.phone,
      maxLength: 13,
      style: TextStyle(
          fontSize: Sizes.fontLgSize,
          color: ColorPalette.fontBlackColor,
          fontWeight: FontWeight.w500),
      cursorColor: ColorPalette.primaryColor,
      decoration: InputDecoration(
        counterText: "",
        labelText: hintText,
        labelStyle: TextStyle(
          fontSize: Sizes.fontLgSize,
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: ColorPalette.fontGreyColor,
        border: UnderlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelStyle: TextStyle(
            color: ColorPalette.fontLightColor, fontSize: Sizes.fontMdSize),
        filled: true,
        fillColor: ColorPalette.whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
