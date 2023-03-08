import 'package:flutter/material.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';

class AppButton extends StatelessWidget {
  const AppButton({required this.onTap, required this.text, super.key});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 15, left: 44, right: 44),
        decoration: BoxDecoration(
            gradient: Gradients.defaultGradient,
            borderRadius: BorderRadius.circular(25)),
        child: Text(
          text,
          style: const TextStyle(
              color: ColorPalette.whiteColor, fontSize: kDefaultFontSize),
        ),
      ),
    );
  }
}
