import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/routes/page_route_transition.dart';
import 'package:travel_app/screens/detail_hotel/detail_hotel_screen.dart';
import 'package:travel_app/screens/home/home_screen.dart';
import 'package:travel_app/screens/login/login_screen.dart';
import 'package:travel_app/screens/reset_password/reset_password.screen.dart';
import 'package:travel_app/screens/result_hotel/result_hotel_screen.dart';
import 'package:travel_app/screens/introdution/intro_screen.dart';
import 'package:travel_app/screens/search_hotel/search_hotel_screen.dart';
import 'package:travel_app/screens/search_hotel/select_date_screen.dart';
import 'package:travel_app/screens/search_hotel/select_guest_room_screen.dart';
import 'package:travel_app/screens/signup/signup.screen.dart';
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
      case routes.resultHotelRoute:
        return MaterialPageRoute(
          builder: (_) => const ResultHotelScreen(),
        );
      case routes.detailHotelRoute:
        return PageRouteTransition(
          direction: AxisDirection.left,
          child: DetailHotelScreen(id: settings.arguments as String),
        );
      case routes.searchHotelRoute:
        return PageRouteTransition(
          direction: AxisDirection.left,
          child: const SearchHotelScreen(),
        );
      case routes.selectDateRoute:
        final defaultDateRange = settings.arguments as PickerDateRange?;
        return MaterialPageRoute(
          builder: (_) => SelectDateScreen(defaultDateRange: defaultDateRange),
        );
      case routes.selectGuestRoomScreen:
        final defaultValues = settings.arguments as Map<String, int?>;
        return MaterialPageRoute(
          builder: (_) => SelectGuestRoomScreen(
              nbGuests: defaultValues['guest'], nbRooms: defaultValues['room']),
        );
      case routes.introduceRoute:
        return PageRouteTransition(
            direction: AxisDirection.left, child: const IntroScreen());
      case routes.signInRoute:
        return PageRouteTransition(
            direction: AxisDirection.left, child: const LoginScreen());
      case routes.signUpRoute:
        return PageRouteTransition(
            direction: AxisDirection.left, child: const SignUpScreen());
      case routes.resetPasswordRoute:
        return PageRouteTransition(
            direction: AxisDirection.left, child: const ResetPassword());
      default:
        return null;
    }
  }
}
