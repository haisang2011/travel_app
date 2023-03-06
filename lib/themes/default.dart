import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/constants/colors.dart';

var theme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light(
    primary: ColorPalette.primaryColor,
    secondary: ColorPalette.secondaryColor,
  ),
  iconTheme: const IconThemeData(color: ColorPalette.primaryColor),
  buttonTheme: const ButtonThemeData(
    buttonColor: ColorPalette.primaryColor,
  ),
  textSelectionTheme:
      const TextSelectionThemeData(cursorColor: ColorPalette.whiteColor),
  scaffoldBackgroundColor: ColorPalette.backgroundColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: ColorPalette.primaryColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  ),
  canvasColor: ColorPalette.primaryColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.shifting,
    backgroundColor: ColorPalette.primaryColor,
    selectedItemColor: ColorPalette.whiteColor,
    unselectedItemColor: ColorPalette.whiteColor.withOpacity(0.5),
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.primaryColor),
  sliderTheme: const SliderThemeData(
    inactiveTickMarkColor: Colors.transparent,
    activeTickMarkColor: Colors.transparent,
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.all(ColorPalette.primaryColor),
  ),
  dialogBackgroundColor: ColorPalette.backgroundColor,
  toggleButtonsTheme: const ToggleButtonsThemeData(
    selectedColor: ColorPalette.primaryColor,
    selectedBorderColor: Colors.transparent,
    borderColor: Colors.transparent,
    fillColor: Colors.transparent,
  ),
);
