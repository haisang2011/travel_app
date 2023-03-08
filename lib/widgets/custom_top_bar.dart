import 'package:flutter/material.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/images.dart';
import 'package:sizer/sizer.dart';

class CustomTopBar extends StatelessWidget {
  const CustomTopBar({Key? key, required this.child, this.title}) : super(key: key);

  final Widget child;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 25.h,
          child: AppBar(
            centerTitle: true,
            toolbarHeight: 12.5.h,
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
          margin: EdgeInsets.only(top: 25.h - 35),
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: child,
        )
      ],
    );
  }
}