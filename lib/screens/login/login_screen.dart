import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/screens/login/login_bloc.dart';
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
  bool rememberMe = false;
  bool showPassword = false;

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  _onCheckedRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  _onToggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  _signInWithEmailAndPassword() {
    context.read<LoginBloc>().add(const LoginSubmitted());
  }

  Widget _buildBottomChildOnTopBar(TextTheme textTheme) {
    return Column(
      children: [
        Text(
          'Log In',
          style:
              textTheme.titleMedium?.copyWith(color: ColorPalette.whiteColor),
        ),
        const SizedBoxH2(),
        Text(
          'Hi, Welcome back!',
          style: textTheme.labelSmall!.copyWith(color: ColorPalette.whiteColor),
        ),
      ],
    );
  }

  Widget _buildDividerLogIn(TextTheme textTheme) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(height: 1, color: ColorPalette.fontBlackColor)),
        Container(
            margin: EdgeInsets.symmetric(horizontal: Sizes.paddingSmSize),
            child: Text(
              'or log in with',
              style: textTheme.bodyMedium,
            )),
        Expanded(
            flex: 1,
            child: Container(height: 1, color: ColorPalette.fontBlackColor)),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return CustomButton(
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
              style: TextStyle(color: ColorPalette.fontBlackColor),
            )
          ],
        ));
  }

  Widget _buildFacebookButton() {
    return CustomButton(
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
        ));
  }

  Widget _buildNavigateSignUpScreen(TextTheme textTheme) {
    return Row(
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
    );
  }

  Widget _buildLoginButton({required VoidCallback onPressed}) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final isSubmitting = state.status == LoginStatus.submitting;
        return CustomButton(
          onPressed: !isSubmitting ? onPressed : null,
          height: 8.5.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSubmitting) const CircularProgressIndicator(),
              const Text('Login'),
            ],
          ),
        );
      },
    );
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
            bottomChildOnTopBar: _buildBottomChildOnTopBar(textTheme),
            child: Column(children: [
              const SizedBoxH3(),
              const _EmailInput(),
              const SizedBoxH2(),
              _PasswordInput(
                showPassword: showPassword,
                onToggleShowPassword: _onToggleShowPassword,
              ),
              const SizedBoxH3(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCheckBox(
                    text: 'Remember me',
                    isChecked: rememberMe,
                    onChecked: _onCheckedRememberMe,
                  ),
                  Text(
                    'Forgot Password?',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBoxH3(),
              _buildLoginButton(
                onPressed: _signInWithEmailAndPassword,
              ),
              const SizedBoxH3(),
              _buildDividerLogIn(
                textTheme,
              ),
              const SizedBoxH3(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGoogleButton(),
                  _buildFacebookButton(),
                ],
              ),
              const SizedBoxH2(),
              _buildNavigateSignUpScreen(textTheme),
            ])),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginEmailChanged(email: value),
              ),
          hintText: 'Email',
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    Key? key,
    required this.onToggleShowPassword,
    required this.showPassword,
  }) : super(key: key);

  final VoidCallback onToggleShowPassword;
  final bool showPassword;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          onChanged: (value) {
            context.read<LoginBloc>().add(
                  LoginPasswordChanged(password: value),
                );
          },
          hintText: 'Password',
          obscureText: !showPassword,
          suffixIcon: GestureDetector(
            onTap: onToggleShowPassword,
            child: Icon(
              !showPassword
                  ? FontAwesomeIcons.solidEyeSlash
                  : FontAwesomeIcons.solidEye,
              color: ColorPalette.fontGreyColor,
            ),
          ),
        );
      },
    );
  }
}
