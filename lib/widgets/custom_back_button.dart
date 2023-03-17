import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
            color: ColorPalette.whiteColor,
            borderRadius: BorderRadius.circular(10.sp)),
        child: Icon(
          FontAwesomeIcons.arrowLeft,
          size: Sizes.fontMdSize,
          color: ColorPalette.thirdColor,
        ),
      ),
    );
  }
}
