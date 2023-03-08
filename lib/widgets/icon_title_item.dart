import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/dismension.dart';

class IconTitleItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback? onPressed;

  const IconTitleItem({
    required this.icon,
    required this.color,
    required this.title,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 25.sp,
          height: 25.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.radiusSmSize),
            color: color.withOpacity(0.2),
          ),
          child: TextButton(
            onPressed: onPressed,
            child: Icon(icon, color: color, size: Sizes.iconMdSize),
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          width: 15.w,
          child: Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: Sizes.fontXsSize,
                  )),
        ),
      ],
    );
  }
}
