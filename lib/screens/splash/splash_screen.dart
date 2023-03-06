import 'dart:async';
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
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(routes.homeRoute, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Splashscreen'));
  }
}
