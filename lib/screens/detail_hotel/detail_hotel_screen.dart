import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/dashed_divider.dart';
import 'package:travel_app/widgets/icon_title_item.dart';

class DetailHotelScreen extends StatefulWidget {
  const DetailHotelScreen({super.key});

  @override
  State<DetailHotelScreen> createState() => _DetailHotelScreenState();
}

class _DetailHotelScreenState extends State<DetailHotelScreen> {
  final controller = PageController(initialPage: 0);

  List<Widget> get listImages {
    return List.generate(
      2,
      (index) => Image.asset(
        '${ImagePath.hotelGrandLuxury}${index + 1}.png',
        fit: BoxFit.cover,
      ),
    ).toList();
  }

  Widget _buildIconRow({
    required Widget icon,
    required List<Widget> children,
    Widget? trailing,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Sizes.paddingXsSize),
      width: double.infinity,
      child: Row(
        children: [
          icon,
          SizedBox(width: 1.5.w),
          Expanded(
            child: Wrap(children: children),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: Sizes.titleXsSize,
            ),
      ),
    );
  }

  Widget _buildContent(String content) {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.2.sp,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: PageView.builder(
              controller: controller,
              itemBuilder: (_, index) => listImages[index % listImages.length],
            ),
          ),
          AppHeader(
            leadingIcon: Icons.arrow_back,
            onPressedLeading: () {
              Navigator.of(context).pop();
            },
            trailingIcon: Icons.favorite,
            trailingIconColor: ColorPalette.vanillaIceColor,
            onPressedTrailing: () {},
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      dotColor: ColorPalette.altoGreyColor,
                      activeDotColor: ColorPalette.whiteColor,
                      dotWidth: 0.8.h,
                      dotHeight: 0.8.h,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorPalette.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Sizes.radiusLgSize),
                          topRight: Radius.circular(Sizes.radiusLgSize),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 0.8.h,
                            width: 24.w,
                            margin: EdgeInsets.all(Sizes.paddingSmSize),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Sizes.radiusMdSize),
                              color: ColorPalette.blackColor,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Padding(
                                padding: EdgeInsets.all(Sizes.paddingLgSize),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Grand Luxury’s',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '\$245',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Text(
                                              '/night',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    fontSize: Sizes.fontXsSize,
                                                    height: 2.5.sp,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.5.h),
                                    _buildIconRow(
                                      icon: Icon(
                                        Icons.location_on,
                                        color: ColorPalette.frolyColor,
                                        size: Sizes.iconLgSize,
                                      ),
                                      children: [
                                        Text('Seoul, South Korea',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ],
                                    ),
                                    const DashedDivider(
                                      color: ColorPalette.mercuryGreyColor,
                                    ),
                                    _buildIconRow(
                                      icon: Icon(
                                        Icons.star,
                                        color: ColorPalette.amberColor,
                                        size: Sizes.iconLgSize,
                                      ),
                                      trailing: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'See All',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                color: ColorPalette.indigoColor,
                                              ),
                                        ),
                                      ),
                                      children: [
                                        Text(
                                          '4.2/5 ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                          '(2456 reviews)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color:
                                                    ColorPalette.fontGreyColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const DashedDivider(
                                      color: ColorPalette.mercuryGreyColor,
                                    ),
                                    SizedBox(height: 2.h),
                                    _buildTitle('Information'),
                                    SizedBox(height: 2.h),
                                    _buildContent(
                                        '''You will find every comfort because many of the 
services that the hotel offers for travellers and of 
course the hotel is very comfortable.'''),
                                    SizedBox(height: 2.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        IconTitleItem(
                                          icon: Icons.restaurant,
                                          color: ColorPalette.indigoColor,
                                          title: 'Restaurant',
                                        ),
                                        IconTitleItem(
                                          icon: Icons.wifi,
                                          color:
                                              ColorPalette.atomicTangerineColor,
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
                                    ),
                                    SizedBox(height: 2.h),
                                    _buildTitle('Location'),
                                    SizedBox(height: 2.h),
                                    _buildContent(
                                        '''Located in the famous neighborhood of Seoul, Grand Luxury’s is set in a building built in the 2010s.'''),
                                    SizedBox(height: 2.h),
                                    SizedBox(
                                      width: double.infinity,
                                      // height: 10.h,
                                      child: Image.asset(ImagePath.sampleMap),
                                    ),
                                    SizedBox(height: 2.h),
                                    CustomButton(
                                      height: 6.5.h,
                                      onPressed: () {},
                                      child: Text(
                                        'Select Room',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: ColorPalette.whiteColor,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
