import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/screens/search_hotel/bloc/search_hotel_bloc.dart';
import 'package:travel_app/screens/search_hotel/widgets/filter_tile.dart';
import 'package:travel_app/screens/search_hotel/widgets/icon_tile.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/routes/routes.dart' as routes;
import 'constants.dart' as constants;

class SearchHotelScreen extends StatelessWidget {
  static final dateFormatter = DateFormat('dd MMM y');
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
            child: BlocBuilder<SearchHotelBloc, SearchHotelState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: 5.h),
                    FilterTile(
                      title: 'Destination',
                      value: state.destination?.toString() ??
                          constants.notChosenYet,
                      icon: Icons.location_on,
                      iconColor: ColorPalette.atomicTangerineColor,
                    ),
                    SizedBox(height: 2.5.h),
                    FilterTile(
                      title: 'Select Date',
                      value: state.dateRange == null
                          ? constants.notChosenYet
                          : '${state.dateRange!.startDate == null ? '???' : dateFormatter.format(state.dateRange!.startDate!)} - ${state.dateRange!.endDate == null ? '???' : dateFormatter.format(state.dateRange!.endDate!)}',
                      icon: Icons.schedule,
                      iconColor: ColorPalette.frolyColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(routes.selectDateRoute,
                            arguments: state.dateRange);
                      },
                    ),
                    SizedBox(height: 2.5.h),
                    FilterTile(
                      title: 'Guest and Room',
                      value:
                          '${state.numberOfGuests} Guest, ${state.numberOfRooms} Room',
                      icon: Icons.bed,
                      iconColor: ColorPalette.greenColor,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            routes.selectGuestRoomScreen,
                            arguments: {
                              'guest': state.numberOfGuests,
                              'room': state.numberOfRooms,
                            });
                      },
                    ),
                    SizedBox(height: 2.5.h),
                    CustomButton(
                      height: 6.5.h,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(routes.resultHotelRoute);
                      },
                      child: Text(
                        'Search',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: ColorPalette.whiteColor,
                            ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
