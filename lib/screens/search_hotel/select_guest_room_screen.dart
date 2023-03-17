import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/screens/search_hotel/bloc/search_hotel_bloc.dart';
import 'package:travel_app/screens/search_hotel/widgets/number_select_tile.dart';
import 'package:travel_app/utils/common_utils.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/widgets/custom_button.dart';

class SelectGuestRoomScreen extends StatefulWidget {
  final int? nbGuests;
  final int? nbRooms;

  const SelectGuestRoomScreen({this.nbGuests, this.nbRooms, super.key});

  @override
  State<SelectGuestRoomScreen> createState() => _SelectGuestRoomScreenState();
}

class _SelectGuestRoomScreenState extends State<SelectGuestRoomScreen> {
  late int _nbGuests;
  late int _nbRooms;

  @override
  void initState() {
    _nbGuests = widget.nbGuests ?? 1;
    _nbRooms = widget.nbRooms ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      leadingIcon: Icons.arrow_back,
      onPressedLeading: () {
        Navigator.of(context).pop();
      },
      title: 'Add guest and room',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.paddingLgSize),
        child: Column(
          children: [
            SizedBox(height: 9.h),
            NumberSelectTile(
              icon: Icons.family_restroom,
              iconColor: ColorPalette.atomicTangerineColor,
              title: 'Guest',
              defaultValue: widget.nbGuests,
              onValueChanged: (value) {
                setState(() {
                  _nbGuests = value;
                });
              },
            ),
            SizedBox(height: 2.5.h),
            NumberSelectTile(
              icon: Icons.bed,
              iconColor: ColorPalette.redColor,
              title: 'Room',
              defaultValue: widget.nbRooms,
              onValueChanged: (value) {
                setState(() {
                  _nbRooms = value;
                });
              },
            ),
            SizedBox(height: 2.5.h),
            CustomButton(
              height: 6.5.h,
              onPressed: () {
                getIt<SearchHotelBloc>().add(GuestAndRoomChanged(
                    nbGuests: _nbGuests, nbRooms: _nbRooms));
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorPalette.whiteColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
