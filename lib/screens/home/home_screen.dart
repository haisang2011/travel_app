import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/widgets/custom_text_field.dart';
import 'package:travel_app/widgets/custom_top_bar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  Widget _buildItem(
      {required String title,
      required Widget icon,
      required Color color,
      required EdgeInsets padding}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color.withOpacity(0.2)),
          height: 75,
          width: 110,
          padding: padding,
          child: icon,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTopBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hi, James!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Where are you going next?',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: SizedBox(
                  height: 45,
                  width: 45,
                  child: Image.asset(ImagePath.imageFirstPageView,
                      fit: BoxFit.cover)),
            )
          ],
        ),
        child: Column(
          children: [
            CustomTextField(
                hintText: 'Search your destination',
                prefixIcon: SvgPicture.asset(SvgPath.searchIcon)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItem(
                    title: 'Hotels',
                    icon: SvgPicture.asset(
                      SvgPath.hotelIcon,
                    ),
                    color: ColorPalette.yellowColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 22)),
                _buildItem(
                    title: 'Flights',
                    icon: SvgPicture.asset(SvgPath.flightIcon),
                    color: ColorPalette.redColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 17)),
                _buildItem(
                    title: 'All',
                    icon: SvgPicture.asset(SvgPath.buildingIcon),
                    color: ColorPalette.greenColor,
                    padding: const EdgeInsets.only(
                        top: 10, left: 25, right: 10, bottom: 20)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Destinations',
                  style: TextStyle(
                      color: ColorPalette.titleTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(color: ColorPalette.thirdColor),
                    ))
              ],
            ),
            SizedBox(
              height: 40.1.h,
              width: double.infinity,
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
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
                            const Text('Korea', style: TextStyle(color: ColorPalette.whiteColor, fontSize: 14, fontWeight: FontWeight.w500),),
                            const SizedBox(height: 10,),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: ColorPalette.whiteColor.withOpacity(0.4),
                              ),
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.solidStar, color: ColorPalette.yellowColor, size: 12.sp),
                                  const SizedBox(width: 8,),
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
      bottomNavigationBar: Container(
        height: 9.2.h,
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
