import 'package:flutter/material.dart';

class ColorPalette {
  static const primaryColor = Color(0xff8F67E8);
  static const secondaryColor = Color(0xff6357CC);
  static const thirdColor = Color(0xff6155CC);
  static const whiteColor = Color(0xffFFFFFF);
  static const blackColor = Color(0xff000000);
  static const backgroundColor = Color(0xffF0F2F6);
  static const frolyColor = Color(0xffF77777);
  static const amberColor = Color(0xffFFC107);
  static const fontBlackColor = Color(0xff313131);
  static const fontGrayColor = Color(0xff838383);
  static const mercuryGrayColor = Color(0xffE5E5E5);
  static const doveGrayColor = Color(0xff636363);
  static const fontLightColor = Color(0xff636363);
  static const fontGreyColor = Color(0xff838383);
  static const mercuryGreyColor = Color(0xffE5E5E5);
  static const ebonyClayColor = Color(0xff2D3143);
  static const vanillaIceColor = Color(0xffF5DCDC);
  static const altoGrayColor = Color(0xffD8D8D8);
  static const indigoColor = Color(0xff6155CC);
  static const atomicTangerineColor = Color(0xffFE9C5E);
  static const turquoiseColor = Color(0xff34C9BD);
  static const yellowColor = Color(0xffFE9C5E);
  static const redColor = Color(0xffF77777);
  static const greenColor = Color(0xff3EC8BC);
  static const backgroundScaffoldColor = Color(0xffF2F2F2);
  static const titleTextColor = Color(0xff313131);
  static const swansDownColor = Color(0xffD9EDEB);
  static const raisinBlackColor = Color(0xff232323);
  static const blueColor = Color(0xff3C5A9A);
  static const errorColor = Color(0xffF93535);
}

class Gradients {
  static const defaultGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorPalette.primaryColor, ColorPalette.secondaryColor]);
}
