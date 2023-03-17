import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/models/hotel.dart';
import 'package:travel_app/screens/detail_hotel/bloc/detail_hotel_bloc.dart';
import 'package:travel_app/screens/detail_hotel/widgets/utilities_view.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/dashed_divider.dart';

class DetailHotelScreen extends StatefulWidget {
  final String id;
  const DetailHotelScreen({required this.id, super.key});

  @override
  State<DetailHotelScreen> createState() => _DetailHotelScreenState();
}

class _DetailHotelScreenState extends State<DetailHotelScreen> {
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    getIt<DetailHotelBloc>().add(DetailHotelFetched(id: widget.id));
    super.initState();
  }

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

  List<Widget> _buildNetworkImageViews(Hotel hotel) {
    return (hotel.images == null || hotel.images!.isEmpty)
        ? <Widget>[
            Image.asset(
              '${ImagePath.hotelGrandLuxury}1.png',
              fit: BoxFit.cover,
            )
          ]
        : hotel.images!
            .map(
              (imageUrl) => CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            )
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailHotelBloc, DetailHotelState>(
        builder: (context, state) {
          if (state is GettingDetailHotel || state is DetailHotelInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetDetailHotelFailure) {
            return Center(
              child: Text(
                'Cannot fetch hotel information:\n${state.errorMessage}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          final hotel = (state as GetDetailHotelSuccess).hotel;
          final imageViews = _buildNetworkImageViews(hotel);

          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (_, index) =>
                      imageViews[index % imageViews.length],
                ),
              ),
              AppHeader(
                hideBanner: true,
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
                        count: imageViews.length,
                        effect: ExpandingDotsEffect(
                          dotColor: ColorPalette.altoGrayColor,
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
                                    padding:
                                        EdgeInsets.all(Sizes.paddingLgSize),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                hotel.name ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '\$${hotel.price}',
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
                                                        fontSize:
                                                            Sizes.fontXsSize,
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
                                            Text(hotel.address ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall),
                                          ],
                                        ),
                                        const DashedDivider(
                                          color: ColorPalette.mercuryGrayColor,
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
                                                    color: ColorPalette
                                                        .indigoColor,
                                                  ),
                                            ),
                                          ),
                                          children: [
                                            Text(
                                              '${hotel.star?.toStringAsFixed(1) ?? 0}/5 ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              '(${hotel.numberReviewers ?? 0} reviews)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: ColorPalette
                                                        .fontGrayColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const DashedDivider(
                                          color: ColorPalette.mercuryGrayColor,
                                        ),
                                        SizedBox(height: 2.h),
                                        _buildTitle('Information'),
                                        SizedBox(height: 2.h),
                                        _buildContent(
                                            '''You will find every comfort because many of the services that the hotel offers for travellers and of course the hotel is very comfortable.'''),
                                        SizedBox(height: 2.h),
                                        const UtilitiesView(),
                                        SizedBox(height: 2.h),
                                        _buildTitle('Location'),
                                        SizedBox(height: 2.h),
                                        _buildContent(
                                            '''Located in the famous neighborhood of Seoul, Grand Luxury’s is set in a building built in the 2010s.'''),
                                        SizedBox(height: 2.h),
                                        SizedBox(
                                          width: double.infinity,
                                          child:
                                              Image.asset(ImagePath.sampleMap),
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
                                                  color:
                                                      ColorPalette.whiteColor,
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
          );
        },
      ),
    );
  }
}
