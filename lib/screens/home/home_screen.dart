import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/screens/home/widgets/destination_list.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/custom_text_field.dart';
import 'package:travel_app/widgets/custom_top_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/routes/routes.dart' as routes;
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  Widget _buildItem({
    required String title,
    required Widget icon,
    required Color color,
    required EdgeInsets padding,
    VoidCallback? onPressed,
  }) {
    return Column(
      children: [
        CustomButton(
          height: 9.h,
          width: 26.w,
          backgroundColor: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(Sizes.radiusLgSize),
          onPressed: onPressed ?? () {},
          child: icon,
        ),
        SizedBox(
          height: 1.5.h,
        ),
        Text(title, style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommonBloc, CommonState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatusEnum.unauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            routes.signInRoute,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: CustomTopBar(
            spacingTopBar: 35,
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<CommonBloc, CommonState>(
                      buildWhen: (previous, current) =>
                          previous.user != current.user,
                      builder: (context, state) {
                        return Text(
                          'Hi, ${state.user.displayName}!',
                          style: TextStyle(
                              fontSize: Sizes.fontXlSize,
                              fontWeight: FontWeight.w500),
                        );
                      },
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      'Where are you going next?',
                      style: TextStyle(
                          fontSize: Sizes.fontXsSize,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const Spacer(flex: 1),
                SvgPicture.asset(
                  SvgPath.notificationIcon,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 15,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: SizedBox(
                      height: 6.h,
                      width: 10.w,
                      child: BlocBuilder<CommonBloc, CommonState>(
                        buildWhen: (previous, current) =>
                            previous.user != current.user,
                        builder: (context, state) {
                          if (state.user.photoURL == null) {
                            return Image.asset(
                              ImagePath.imagePlaceHolder,
                              fit: BoxFit.cover,
                            );
                          } else {
                            return CachedNetworkImage(
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              imageUrl: state.user.photoURL!,
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      )),
                )
              ],
            ),
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Search your destination',
                  prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,
                      size: Sizes.fontLgSize),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildItem(
                        title: 'Hotels',
                        icon: SvgPicture.asset(
                          SvgPath.hotelIcon,
                        ),
                        color: ColorPalette.yellowColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 2.h,
                          horizontal: 2.w,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(routes.searchHotelRoute);
                        }),
                    _buildItem(
                      title: 'Flights',
                      icon: SvgPicture.asset(SvgPath.flightIcon),
                      color: ColorPalette.redColor,
                      padding: EdgeInsets.symmetric(
                        vertical: 1.5.h,
                        horizontal: 2.w,
                      ),
                    ),
                    _buildItem(
                      title: 'All',
                      icon: SvgPicture.asset(SvgPath.buildingIcon),
                      color: ColorPalette.greenColor,
                      padding: EdgeInsets.only(
                        top: 1.h,
                        left: 4.w,
                        bottom: 2.h,
                      ),
                      onPressed: () {
                        getIt<CommonBloc>()
                            .add(AuthenticationLogoutRequested());
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Destinations',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: ColorPalette.thirdColor),
                        ))
                  ],
                ),
                SizedBox(
                  height: 40.h,
                  width: double.infinity,
                  child: const DestinationList(),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 9.5.h,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          color: ColorPalette.secondaryColor.withOpacity(0.1),
          child: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              selectedItemColor: ColorPalette.thirdColor,
              unselectedItemColor: ColorPalette.thirdColor.withOpacity(0.2),
              items: [
                SalomonBottomBarItem(
                    icon: const Icon(FontAwesomeIcons.house),
                    title: const Text('Home')),
                SalomonBottomBarItem(
                    icon: const Icon(FontAwesomeIcons.solidHeart),
                    title: const Text('Likes')),
                SalomonBottomBarItem(
                    icon: const Icon(FontAwesomeIcons.briefcase),
                    title: const Text('Booking')),
                SalomonBottomBarItem(
                    icon: const Icon(FontAwesomeIcons.solidUser),
                    title: const Text('Profile')),
              ]),
        ),
      ),
    );
  }
}
