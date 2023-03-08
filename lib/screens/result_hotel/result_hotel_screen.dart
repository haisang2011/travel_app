import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/screens/result_hotel/widgets/hotel_list.dart';

class ResultHotelScreen extends StatelessWidget {
  const ResultHotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 30.h,
            child: SvgPicture.asset(
              SvgPath.headerBackground,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              AppHeader(
                leadingIcon: Icons.arrow_back,
                onPressedLeading: () {},
                trailingIcon: Icons.menu,
                onPressedTrailing: () {},
                title: 'Hotels',
              ),
              SizedBox(
                height: 80.h,
                child: const HotelList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
