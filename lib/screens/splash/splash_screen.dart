import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/repository/authentication_repository.dart';
import 'package:travel_app/data/source/local_storage/cache_keys.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/routes/routes.dart' as routes;
import 'package:flutter/material.dart';
import 'package:travel_app/utils/common_utils.dart' as commonUtils;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuthenticated(getIt<CommonBloc>().state);
  }

  void checkAuthenticated(CommonState state) async {
    AuthenticationStatusEnum status = state.status;
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    switch (status) {
      case AuthenticationStatusEnum.authenticated:
        commonUtils.navigateNextScreenAfterAuthenticate(context);
        break;
      case AuthenticationStatusEnum.unauthenticated:
        Navigator.of(context).pushNamedAndRemoveUntil(
          routes.signInRoute,
          (route) => false,
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommonBloc, CommonState>(
      listener: (context, state) {
        checkAuthenticated(state);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              ImagePath.imageBackgroundSplash,
              fit: BoxFit.cover,
            )),
            Positioned.fill(
                child: Image.asset(
              ImagePath.imageCircleSplash,
              fit: BoxFit.cover,
            )),
          ],
        ),
      ),
    );
  }
}
