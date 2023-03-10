import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';

class AppHeader extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? title;
  final String? subtitle;
  final VoidCallback? onPressedLeading;
  final VoidCallback? onPressedTrailing;
  final Color? leadingIconColor;
  final Color? trailingIconColor;
  final double? bannerHeight;
  final double headerHeightFactor;
  final double titleHeightFactor;
  final Widget? child;
  final bool hideBanner;
  final Alignment titleAlignment;
  final TextAlign titleTextAlign;

  const AppHeader({
    this.leadingIcon,
    this.trailingIcon,
    this.title,
    this.subtitle,
    this.onPressedLeading,
    this.onPressedTrailing,
    this.leadingIconColor,
    this.trailingIconColor,
    this.bannerHeight,
    this.headerHeightFactor = 3 / 4,
    this.titleHeightFactor = 3 / 4,
    this.hideBanner = false,
    this.titleAlignment = Alignment.center,
    this.titleTextAlign = TextAlign.center,
    this.child,
    super.key,
  });

  bool get hasTitle {
    return title != null || subtitle != null;
  }

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

  Widget _buildHeader(BuildContext context) {
    final bannerHeight = (this.bannerHeight ?? 25.h) * 0.9;
    final headerButtons = Container(
      height: headerHeightFactor * bannerHeight,
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
          (trailingIcon != null)
              ? _buildHeaderButton(
                  context,
                  trailingIcon!,
                  onPressedTrailing,
                  trailingIconColor,
                )
              : SizedBox(width: 5.w),
        ],
      ),
    );
    final header = !hasTitle
        ? headerButtons
        : Stack(
            children: [
              headerButtons,
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 64.w,
                  height: titleHeightFactor * bannerHeight,
                  child: Align(
                    alignment: titleAlignment,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            textAlign: titleTextAlign,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: ColorPalette.whiteColor,
                                ),
                          ),
                        if (subtitle != null)
                          Container(
                            margin: EdgeInsets.only(top: 2.h),
                            child: Text(
                              subtitle!,
                              textAlign: titleTextAlign,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: ColorPalette.whiteColor,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
    return (child == null)
        ? header
        : Column(
            children: [
              header,
              child!,
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return hideBanner
        ? _buildHeader(context)
        : Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: bannerHeight,
                  child: SvgPicture.asset(
                    SvgPath.headerBackground,
                    fit: BoxFit.fill,
                  ),
                ),
                _buildHeader(context)
              ],
            ),
          );
  }
}
