import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/dismension.dart';

class RroundedBackgroundIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  const RroundedBackgroundIcon(
    this.icon, {
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).colorScheme.primary;
    return Container(
      padding: EdgeInsets.all(0.5.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(Sizes.radiusSmSize),
      ),
      child: Icon(
        icon,
        size: Sizes.iconLgSize,
        color: color,
      ),
    );
  }
}
