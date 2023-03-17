import 'package:flutter/material.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/widgets/icon_title_item.dart';

class UtilitiesView extends StatelessWidget {
  const UtilitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        IconTitleItem(
          icon: Icons.restaurant,
          color: ColorPalette.indigoColor,
          title: 'Restaurant',
        ),
        IconTitleItem(
          icon: Icons.wifi,
          color: ColorPalette.atomicTangerineColor,
          title: 'Wifi',
        ),
        IconTitleItem(
          icon: Icons.currency_exchange,
          color: ColorPalette.frolyColor,
          title: 'Currency Exchange',
        ),
        IconTitleItem(
          icon: Icons.desk,
          color: ColorPalette.turquoiseColor,
          title: '24-hour Front Desk',
        ),
        IconTitleItem(
          icon: Icons.more_horiz,
          color: ColorPalette.ebonyClayColor,
          title: 'More',
        ),
      ],
    );
  }
}
