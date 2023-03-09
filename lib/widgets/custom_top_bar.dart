import 'package:flutter/material.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/images.dart';
import 'package:sizer/sizer.dart';

class CustomTopBar extends StatelessWidget {
  const CustomTopBar({Key? key, required this.child, this.title, this.height, this.toolbarHeight}) : super(key: key);

  final Widget child;
  final Widget? title;
  final double? height;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? 25.h;
    final toolbarHeight = this.toolbarHeight ?? 12.5.h;
    return Stack(
      children: [
        SizedBox(
          height: height,
          child: AppBar(
            centerTitle: true,
            toolbarHeight: toolbarHeight,
            backgroundColor: ColorPalette.backgroundScaffoldColor,
            automaticallyImplyLeading: false,
            title: title,
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: Gradients.defaultGradient,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(35))),
                ),
                Image.asset(
                  ImagePath.imageTopLeftOval,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      ImagePath.imagebottomRightOval,
                      fit: BoxFit.cover,
                    )),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: height - 35),
          padding: EdgeInsets.symmetric(horizontal: 6.5.w),
          child: child,
        )
      ],
    );
  }
}