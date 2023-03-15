import 'dart:async';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/source/local_storage/cache_keys.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/routes/routes.dart' as routes;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirectNextScreen();
  }

  void _redirectNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    final bool? ignoreIntro =
        getIt<LocalStorage>().getBoolean(key: CacheKey.ignoreIntro);
    if (!mounted) return;
    if (ignoreIntro != null && ignoreIntro) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routes.homeRoute, (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routes.introduceRoute, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
