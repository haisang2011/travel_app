import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox(
      {Key? key,
      this.height,
      this.backgroundColor,
      this.checkedColor,
      this.width,
      this.text = '',
      required this.isChecked,
      required this.onChecked,
      })
      : super(key: key);

  final bool isChecked;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? checkedColor;
  final VoidCallback onChecked;
  final String text;

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? 4.h;
    final width = this.width ?? 7.w;
    final backgroundColor = this.backgroundColor ?? ColorPalette.whiteColor;
    final checkedColor = this.checkedColor ?? ColorPalette.thirdColor;
    return GestureDetector(
      onTap: onChecked,
      child: Row(
        children: [Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: backgroundColor),
          height: height,
          width: width,
          child: isChecked ? Icon(
                  FontAwesomeIcons.check,
                  size: 13.sp,
                  color: checkedColor,
                ) : null
        ), if (text.isNotEmpty) const SizedBox(width: 10,), Text(text, style: Theme.of(context).textTheme.bodyMedium,)]
      ),
    );
  }
}
