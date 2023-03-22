import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/repository/authentication_repository.dart';
import 'package:travel_app/widgets/custom_back_button.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/custom_phone_number_field.dart';
import 'package:travel_app/widgets/custom_sized_box.dart';
import 'package:travel_app/widgets/custom_top_bar.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    return Scaffold(
      body: CustomTopBar(
        title: const CustomBackButton(),
        centerTitle: false,
        bottomChildOnTopBar: Column(
          children: [
            Text(
              'Forgot Password',
              style: textTheme.titleMedium
                  ?.copyWith(color: ColorPalette.whiteColor),
            ),
            const SizedBoxH2(),
            Text(
              'You’ll get messages soon on your e-mail address',
              style: textTheme.labelSmall!
                  .copyWith(color: ColorPalette.whiteColor),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBoxH4(),
            const CustomPhoneNumberField(
              hintText: 'Enter phone number',
            ),
            const SizedBoxH3(),
            CustomButton(
              height: 9.h,
              width: double.infinity,
              onPressed: () {
                getIt<AuthenticationRepository>().resetPassword();
              },
              child: const Text(
                'Send',
                style: TextStyle(
                  color: ColorPalette.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
