import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/screens/result_hotel/widgets/hotel_list.dart';

class ResultHotelScreen extends StatelessWidget {
  const ResultHotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      leadingIcon: Icons.arrow_back,
      onPressedLeading: () {
        Navigator.of(context).pop();
      },
      trailingIcon: Icons.menu,
      onPressedTrailing: () {},
      title: 'Hotels',
      child: SizedBox(
        height: 83.h,
        child: const HotelList(),
      ),
    );
  }
}
