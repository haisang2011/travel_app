import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/screens/search_hotel/widgets/rounded_background_icon.dart';

class IconTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;
  final Widget child;
  final Widget? trailing;

  const IconTile({
    required this.icon,
    required this.iconColor,
    required this.child,
    this.onPressed,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.radiusSmSize),
        color: ColorPalette.whiteColor,
      ),
      child: InkWell(
        highlightColor: ColorPalette.whiteColor,
        borderRadius: BorderRadius.circular(Sizes.radiusSmSize),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.paddingMdSize, vertical: Sizes.paddingSmSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RroundedBackgroundIcon(icon, color: iconColor),
              SizedBox(width: 4.w),
              Expanded(child: child),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
