import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/screens/search_hotel/widgets/icon_tile.dart';

class FilterTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;
  final String title;
  final String value;

  const FilterTile({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconTile(
      icon: icon,
      iconColor: iconColor,
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorPalette.doveGrayColor,
                ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: Sizes.fontMdSize),
          ),
        ],
      ),
    );
  }
}
