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
import 'package:travel_app/widgets/custom_phone_number_field.dart';
import 'package:travel_app/widgets/custom_sized_box.dart';
import 'package:travel_app/widgets/custom_text_field.dart';
import 'package:travel_app/widgets/custom_top_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  'Sign Up',
                  style: textTheme.titleMedium
                      ?.copyWith(color: ColorPalette.whiteColor),
                ),
                SizedBoxH2(),
                Text(
                  'Let\’s create your account!',
                  style: textTheme.labelSmall!
                      .copyWith(color: ColorPalette.whiteColor),
                ),
              ],
            ),
            child: Column(children: [
              const SizedBoxH3(),
              const CustomTextField(
                hintText: 'Name',
              ),
              const SizedBoxH2(),
              const CustomTextField(
                hintText: 'Country',
              ),
              const SizedBoxH2(),
              CustomPhoneNumberField(
                hintText: 'Phone Number',
              ),
              const SizedBoxH2(),
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
              Wrap(alignment: WrapAlignment.center, spacing: 4, children: [
                Text('By tapping sign up you agree to the',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 11.sp)),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Text('Terms and',
                          style: textTheme.bodyMedium?.copyWith(
                              color: ColorPalette.thirdColor, fontSize: 11.sp)),
                    )),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Text('Condition',
                          style: textTheme.bodyMedium?.copyWith(
                              color: ColorPalette.thirdColor,
                              fontSize: 11.sp,
                              height: 1.75)),
                    )),
                Text('and',
                    style: textTheme.bodyMedium
                        ?.copyWith(fontSize: 11.sp, height: 1.75)),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Text('Privacy Policy',
                          style: textTheme.bodyMedium?.copyWith(
                              color: ColorPalette.thirdColor,
                              fontSize: 11.sp,
                              height: 1.75)),
                    )),
                Text('of this app',
                    style: textTheme.bodyMedium
                        ?.copyWith(fontSize: 11.sp, height: 1.75))
              ]),
              const SizedBoxH3(),
              CustomButton(
                onPressed: () {},
                child: Text('Sign Up'),
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
                        'or sign up with',
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
              SizedBoxH4(),
            ])),
      ),
    );
  }
}
