import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/widgets/app_button.dart';
import 'package:travel_app/widgets/custom_back_button.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/custom_checkbox.dart';
import 'package:travel_app/widgets/custom_sized_box.dart';
import 'package:travel_app/widgets/custom_text_field.dart';
import 'package:travel_app/widgets/custom_top_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = true;

  _onCheckedRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomTopBar(
            centerTitle: false,
            title: const CustomBackButton(),
            bottomChildOnTopBar: Column(
              children: [
                Text(
                  'LogIn',
                  style: textTheme.titleMedium
                      ?.copyWith(color: ColorPalette.whiteColor),
                ),
                SizedBoxH2(),
                Text(
                  'Hi, Welcome back!',
                  style: textTheme.labelSmall!
                      .copyWith(color: ColorPalette.whiteColor),
                ),
              ],
            ),
            child: Column(children: [
              const SizedBoxH3(),
              const CustomTextField(
                hintText: 'Email',
              ),
              const SizedBoxH2(),
              const CustomTextField(
                hintText: 'Password',
                obscureText: true,
                suffixIcon: Icon(
                  FontAwesomeIcons.solidEyeSlash,
                  color: ColorPalette.fontGreyColor,
                ),
              ),
              const SizedBoxH3(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCheckBox(
                      text: 'Remember me',
                      isChecked: rememberMe,
                      onChecked: _onCheckedRememberMe),
                  Text('Forgot Password?', style: textTheme.bodyMedium),
                ],
              ),
              const SizedBoxH3(),
              CustomButton(
                onPressed: () {},
                child: Text('Login'),
                height: 8.5.h,
              ),
              const SizedBoxH3(),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          height: 1, color: ColorPalette.fontBlackColor)),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: Sizes.paddingSmSize),
                      child: Text(
                        'or log in with',
                        style: textTheme.bodyMedium,
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                          height: 1, color: ColorPalette.fontBlackColor)),
                ],
              ),
              SizedBoxH3(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      onPressed: () {},
                      backgroundColor: ColorPalette.whiteColor,
                      height: 8.5.h,
                      width: 40.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(SvgPath.googleIcon),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Google',
                            style:
                                TextStyle(color: ColorPalette.fontBlackColor),
                          )
                        ],
                      )),
                  CustomButton(
                      onPressed: () {},
                      backgroundColor: ColorPalette.blueColor,
                      height: 8.5.h,
                      width: 40.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(FontAwesomeIcons.facebookF),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Facebook')
                        ],
                      ))
                ],
              ),
              SizedBoxH2(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\’t have an account?'),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: textTheme.bodyMedium
                            ?.copyWith(color: ColorPalette.thirdColor),
                      ))
                ],
              ),
            ])),
      ),
    );
  }
}
