import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/screens/search_hotel/widgets/filter_tile.dart';
import 'package:travel_app/screens/search_hotel/widgets/icon_tile.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/routes/routes.dart' as routes;

class SearchHotelScreen extends StatelessWidget {
  const SearchHotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      leadingIcon: Icons.arrow_back,
      onPressedLeading: () {
        Navigator.of(context).pop();
      },
      titleHeightFactor: 0.95,
      title: 'Hotel Booking',
      subtitle: 'Choose your favorite hotel and enjoy the service',
      titleAlignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.paddingLgSize,
            ),
            child: Column(
              children: [
                SizedBox(height: 5.h),
                const FilterTile(
                  title: 'Destination',
                  value: 'South Korea',
                  icon: Icons.location_on,
                  iconColor: ColorPalette.atomicTangerineColor,
                ),
                SizedBox(height: 2.5.h),
                FilterTile(
                  title: 'Select Date',
                  value: '13 Feb - 18 Feb 2021',
                  icon: Icons.schedule,
                  iconColor: ColorPalette.frolyColor,
                  onPressed: () {
                    Navigator.of(context).pushNamed(routes.selectDateRoute);
                  },
                ),
                SizedBox(height: 2.5.h),
                FilterTile(
                  title: 'Guest and Room',
                  value: '2 Guest, 1 Room',
                  icon: Icons.bed,
                  iconColor: ColorPalette.greenColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(routes.selectGuestRoomScreen);
                  },
                ),
                SizedBox(height: 2.5.h),
                CustomButton(
                  height: 6.5.h,
                  onPressed: () {
                    Navigator.of(context).pushNamed(routes.resultHotelRoute);
                  },
                  child: Text(
                    'Search',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorPalette.whiteColor,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
