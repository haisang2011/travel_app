import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/source/local_storage/cache_keys.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/widgets/app_button.dart';
import 'package:travel_app/routes/routes.dart' as routes;
import 'package:sizer/sizer.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _pageViewController = PageController();
  final StreamController _pageViewStreamController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _pageViewController.addListener(() {
      _pageViewStreamController.add(_pageViewController.page!.toInt());
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _pageViewStreamController.close();
    super.dispose();
  }

  _onNextPageView() async {
    await Future.delayed(const Duration(milliseconds: 250));
    if (_pageViewController.page != 2) {
      _pageViewController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.bounceOut);
    } else {
      getIt<LocalStorage>().putBoolean(key: CacheKey.ignoreIntro, value: true);
      if (!mounted) return;
      Navigator.of(context).pushNamed(routes.homeRoute);
    }
  }

  Widget _buildPageView(String imagePath, String title, String subTitle,
      AlignmentGeometry alignmentGeometry) {
    return Stack(children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            alignment: alignmentGeometry,
            child: Image.asset(
              imagePath,
              height: 50.h,
              fit: BoxFit.fitHeight,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: kMediumFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subTitle,
                style: const TextStyle(fontSize: kSmallFontSize, height: 1.75),
              ),
            ],
          ),
        )
      ]),
      Positioned(
        bottom: 5.h,
        left: 5.w,
        right: 5.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothPageIndicator(
              controller: _pageViewController,
              count: 3,
              effect: const ExpandingDotsEffect(
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  spacing: 4.0,
                  activeDotColor: ColorPalette.yellowColor),
            ),
            StreamBuilder<dynamic>(
                initialData: 0,
                stream: _pageViewStreamController.stream,
                builder: (context, snapshot) {
                  return AppButton(
                      onTap: _onNextPageView,
                      text: snapshot.data != 2 ? 'Next' : 'Get Started');
                })
          ],
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      left: false,
      right: false,
      child: PageView(
        controller: _pageViewController,
        children: [
          _buildPageView(
              ImagePath.imageFirstPageView,
              'Book a flight',
              'Found a flight that matches your destination and schedule? Book it instantly.',
              Alignment.topRight),
          _buildPageView(
              ImagePath.imageSecondPageView,
              'Find a hotel room',
              'Select the day, book your room. We give you the best price.',
              Alignment.center),
          _buildPageView(
              ImagePath.imageThirdPageView,
              'Enjoy your trip',
              'Easy discovering new places and share these between your friends and travel together.',
              Alignment.topLeft),
        ],
      ),
    ));
  }
}
