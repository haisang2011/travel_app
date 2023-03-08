import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';

class AppHeader extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? title;
  final VoidCallback? onPressedLeading;
  final VoidCallback? onPressedTrailing;
  final Color? leadingIconColor;
  final Color? trailingIconColor;

  const AppHeader({
    this.leadingIcon,
    this.trailingIcon,
    this.title,
    this.onPressedLeading,
    this.onPressedTrailing,
    this.leadingIconColor,
    this.trailingIconColor,
    super.key,
  });

  Widget _buildHeaderButton(
    BuildContext context,
    IconData icon,
    VoidCallback? onPressed,
    Color? iconColor,
  ) {
    return SizedBox(
      width: 25.sp,
      height: 25.sp,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: ColorPalette.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.radiusSmSize),
          ),
        ),
        child: Icon(
          icon,
          color: iconColor ?? Theme.of(context).colorScheme.primary,
          size: Sizes.iconMdSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      padding: EdgeInsets.symmetric(horizontal: Sizes.paddingLgSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leadingIcon != null)
            _buildHeaderButton(
              context,
              leadingIcon!,
              onPressedLeading,
              leadingIconColor,
            ),
          if (title != null)
            Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorPalette.whiteColor,
                  ),
            ),
          if (trailingIcon != null)
            _buildHeaderButton(
              context,
              trailingIcon!,
              onPressedTrailing,
              trailingIconColor,
            ),
        ],
      ),
    );
  }
}
