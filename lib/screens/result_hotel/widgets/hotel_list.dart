import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/screens/result_hotel/widgets/hotel_card.dart';

class HotelList extends StatelessWidget {
  const HotelList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Sizes.paddingLgSize),
      children: const [
        HotelCard(),
        HotelCard(),
        HotelCard(),
        HotelCard(),
        HotelCard(),
        HotelCard(),
      ],
    );
  }
}
