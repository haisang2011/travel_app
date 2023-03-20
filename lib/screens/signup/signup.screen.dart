import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/screens/signup/bloc/sign_up_bloc.dart';
import 'package:travel_app/screens/signup/signup_validator.dart';
import 'package:travel_app/widgets/custom_back_button.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/custom_phone_number_field.dart';
import 'package:travel_app/widgets/custom_sized_box.dart';
import 'package:travel_app/widgets/custom_text_field.dart';
import 'package:travel_app/widgets/custom_top_bar.dart';
import 'package:travel_app/routes/routes.dart' as routes;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = true;

  void _snackbar(bool isSuccess, String? message) {
    final snackBar = isSuccess
        ? SnackBar(
            content: Text(
              message!,
              style: const TextStyle(color: ColorPalette.whiteColor),
            ),
            backgroundColor: ColorPalette.greenColor,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 2000),
            elevation: 2,
          )
        : SnackBar(
            content: Text(
              message ?? 'Authentication Error',
              style: const TextStyle(color: ColorPalette.whiteColor),
            ),
            backgroundColor: ColorPalette.redColor,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 2000),
            elevation: 2,
          );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.success) {
          _snackbar(true, 'Sign up successfully!');
          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(routes.signInRoute, (route) => false);
          });
        } else if (state.status == SignUpStatus.error) {
          _snackbar(false, state.errorMessage);
        }
      },
      child: Scaffold(
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
                  const SizedBoxH2(),
                  Text(
                    'Let\’s create your account!',
                    style: textTheme.labelSmall!
                        .copyWith(color: ColorPalette.whiteColor),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBoxH3(),
                  const _NameField(),
                  const SizedBoxH2(),
                  const _PhoneNumberField(),
                  const SizedBoxH2(),
                  const _EmailField(),
                  const SizedBoxH2(),
                  const _PasswordField(),
                  const SizedBoxH3(),
                  const _PrivacyPolicy(),
                  const SizedBoxH3(),
                  _SignUpButton(formKey: _formKey),
                  const SizedBoxH3(),
                  const _Divider(),
                  const SizedBoxH3(),
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
                                style: TextStyle(
                                    color: ColorPalette.fontBlackColor),
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
                  const SizedBoxH4(),
                ]),
              )),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 1,
            color: ColorPalette.fontBlackColor,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Sizes.paddingSmSize,
          ),
          child: Text(
            'or sign up with',
            style: textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 1,
            color: ColorPalette.fontBlackColor,
          ),
        ),
      ],
    );
  }
}

class _SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _SignUpButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          getIt<SignUpBloc>().add(const SignUpSubmitted());
        }
      },
      height: 8.5.h,
      child: const Text('Sign Up'),
    );
  }
}

class _PrivacyPolicy extends StatelessWidget {
  const _PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: [
        Text(
          'By tapping sign up you agree to the',
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 11.sp,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            child: Text(
              'Terms and',
              style: textTheme.bodyMedium?.copyWith(
                color: ColorPalette.thirdColor,
                fontSize: 11.sp,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            child: Text(
              'Condition',
              style: textTheme.bodyMedium?.copyWith(
                color: ColorPalette.thirdColor,
                fontSize: 11.sp,
                height: 1.75,
              ),
            ),
          ),
        ),
        Text(
          'and',
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 11.sp,
            height: 1.75,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            child: Text(
              'Privacy Policy',
              style: textTheme.bodyMedium?.copyWith(
                color: ColorPalette.thirdColor,
                fontSize: 11.sp,
                height: 1.75,
              ),
            ),
          ),
        ),
        Text(
          'of this app',
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 11.sp,
            height: 1.75,
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    super.key,
  });

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _showPassword = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          getIt<SignUpBloc>()
              .add(SignUpPasswordChanged(password: _passwordController.text));
        }
      },
      child: CustomTextField(
        hintText: 'Password',
        validator: (value) => SignUpValidator.validatePassword(value),
        controller: _passwordController,
        obscureText: !_showPassword,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword
                ? FontAwesomeIcons.solidEye
                : FontAwesomeIcons.solidEyeSlash,
            color: ColorPalette.fontGreyColor,
          ),
        ),
      ),
    );
  }
}

class _EmailField extends StatefulWidget {
  const _EmailField({
    super.key,
  });

  @override
  State<_EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<_EmailField> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          getIt<SignUpBloc>()
              .add(SignUpEmailChanged(email: _emailController.text));
        }
      },
      child: CustomTextField(
        hintText: 'Email',
        validator: (value) => SignUpValidator.validateEmail(value),
        controller: _emailController,
      ),
    );
  }
}

class _PhoneNumberField extends StatefulWidget {
  const _PhoneNumberField({
    super.key,
  });

  @override
  State<_PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<_PhoneNumberField> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          getIt<SignUpBloc>().add(
            SignUpPhoneNumberChanged(phoneNumber: _phoneNumberController.text),
          );
        }
      },
      child: CustomPhoneNumberField(
        hintText: 'Phone Number',
        controller: _phoneNumberController,
        validator: (value) => SignUpValidator.validatePhoneNumber(value),
      ),
    );
  }
}

class _NameField extends StatefulWidget {
  const _NameField({
    super.key,
  });

  @override
  State<_NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<_NameField> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          getIt<SignUpBloc>()
              .add(SignUpNameChanged(name: _nameController.text));
        }
      },
      child: CustomTextField(
        hintText: 'Name',
        validator: (value) => SignUpValidator.validateName(value),
        controller: _nameController,
      ),
    );
  }
}
