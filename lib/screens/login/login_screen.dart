import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/source/local_storage/cache_keys.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/screens/login/bloc/login_bloc.dart';
import 'package:travel_app/screens/login/login_validator.dart';
import 'package:travel_app/widgets/app_button.dart';
import 'package:travel_app/widgets/custom_back_button.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/custom_checkbox.dart';
import 'package:travel_app/widgets/custom_sized_box.dart';
import 'package:travel_app/widgets/custom_text_field.dart';
import 'package:travel_app/widgets/custom_top_bar.dart';
import 'package:travel_app/routes/routes.dart' as routes;
import 'package:travel_app/utils/common_utils.dart' as commonUtils;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  _onCheckedRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
    });
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
        onPressed: () {
          getIt<CommonBloc>().add(AuthenticationLogoutRequested());
        },
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
            onPressed: () {
              Navigator.of(context).pushNamed(routes.signUpRoute);
            },
            child: Text(
              'Sign Up',
              style: textTheme.bodyMedium
                  ?.copyWith(color: ColorPalette.thirdColor),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Authentication Error',
                    style: const TextStyle(color: ColorPalette.whiteColor),
                  ),
                  backgroundColor: ColorPalette.redColor,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(milliseconds: 2000),
                  elevation: 2,
                ),
              );
            } else if (state.status == LoginStatus.success) {
              commonUtils.navigateNextScreenAfterAuthenticate(context);
            }
          },
          child: CustomTopBar(
              centerTitle: false,
              // title: const CustomBackButton(),
              bottomChildOnTopBar: _buildBottomChildOnTopBar(textTheme),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBoxH3(),
                  const _EmailInput(),
                  const SizedBoxH2(),
                  const _PasswordInput(),
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
                  _LoginButton(formKey: _formKey),
                  const SizedBoxH3(),
                  _buildDividerLogIn(textTheme),
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
                ]),
              )),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _LoginButton({Key? key, required this.formKey}) : super(key: key);

  _signInWithEmailAndPassword(BuildContext context) {
    context.read<LoginBloc>().add(const LoginSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final isSubmitting = state.status == LoginStatus.submitting;
        return CustomButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              !isSubmitting ? _signInWithEmailAndPassword(context) : null;
            }
          },
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
}

class _EmailInput extends StatefulWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
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
          getIt<LoginBloc>()
              .add(LoginEmailChanged(email: _emailController.text));
        }
      },
      child: CustomTextField(
        hintText: 'Email',
        controller: _emailController,
        validator: (value) => LoginValidator.validateEmail(value),
      ),
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;
  _onToggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              getIt<LoginBloc>().add(
                  LoginPasswordChanged(password: _passwordController.text));
            }
          },
          child: CustomTextField(
            controller: _passwordController,
            validator: (value) => LoginValidator.validatePassword(value),
            hintText: 'Password',
            obscureText: !_showPassword,
            suffixIcon: GestureDetector(
              onTap: _onToggleShowPassword,
              child: Icon(
                _showPassword
                    ? FontAwesomeIcons.solidEye
                    : FontAwesomeIcons.solidEyeSlash,
                color: ColorPalette.fontGreyColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
