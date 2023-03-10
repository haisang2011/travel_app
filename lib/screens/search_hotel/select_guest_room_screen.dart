import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/screens/search_hotel/widgets/number_select_tile.dart';
import 'package:travel_app/utils/common_utils.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/widgets/custom_button.dart';

class SelectGuestRoomScreen extends StatelessWidget {
  const SelectGuestRoomScreen({super.key});

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
              onValueChanged: (value) {
                printTest(value);
              },
            ),
            SizedBox(height: 2.5.h),
            NumberSelectTile(
              icon: Icons.bed,
              iconColor: ColorPalette.redColor,
              title: 'Room',
              onValueChanged: (value) {
                printTest(value);
              },
            ),
            SizedBox(height: 2.5.h),
            CustomButton(
              height: 6.5.h,
              onPressed: () {
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
