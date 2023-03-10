import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/custom_text_field.dart';
import 'package:travel_app/widgets/custom_top_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/routes/routes.dart' as routes;

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
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomTopBar(
          spacingTopBar: 35,
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, James!',
                    style: TextStyle(
                        fontSize: Sizes.fontXlSize,
                        fontWeight: FontWeight.w500),
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
                    height: 5.h,
                    width: 10.w,
                    child: Image.asset(ImagePath.imageFirstPageView,
                        fit: BoxFit.cover)),
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
                          vertical: 1.5.h, horizontal: 2.w)),
                  _buildItem(
                      title: 'All',
                      icon: SvgPicture.asset(SvgPath.buildingIcon),
                      color: ColorPalette.greenColor,
                      padding:
                          EdgeInsets.only(top: 1.h, left: 4.w, bottom: 2.h)),
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
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.5.h,
                  crossAxisSpacing: 2.5.h,
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            "https://source.unsplash.com/random?sig=$index"),
                      ),
                      Positioned(
                          left: 10,
                          bottom: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Korea',
                                style: TextStyle(
                                    color: ColorPalette.whiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color:
                                      ColorPalette.whiteColor.withOpacity(0.4),
                                ),
                                child: Row(
                                  children: [
                                    Icon(FontAwesomeIcons.solidStar,
                                        color: ColorPalette.yellowColor,
                                        size: 12.sp),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text('4.5'),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
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
    );
  }
}
