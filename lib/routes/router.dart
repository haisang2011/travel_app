import 'package:travel_app/routes/page_route_transition.dart';
import 'package:travel_app/screens/home/home_screen.dart';
import 'package:travel_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'routes.dart' as routes;

class AppRouter {
  late Widget rootScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    rootScreen = const SplashScreen();

    switch (settings.name) {
      case routes.rootRoute:
        return MaterialPageRoute(builder: (_) => rootScreen);
      case routes.homeRoute:
        return PageRouteTransition(
          direction: AxisDirection.left,
          child: const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
