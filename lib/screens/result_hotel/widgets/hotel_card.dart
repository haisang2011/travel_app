import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/repository/location_repository.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/dashed_divider.dart';
import 'package:travel_app/routes/routes.dart' as routes;

import '../../../utils/common_utils.dart';

class HotelCard extends StatelessWidget {
  final String id;
  final String? imageUrl;
  final String? name;
  final String? address;
  final double? star;
  final int? numberReviewers;
  final int? price;
  final double? distance;

  const HotelCard({
    required this.id,
    this.imageUrl,
    this.name,
    this.address,
    this.star,
    this.numberReviewers,
    this.price,
    this.distance,
    super.key,
  });

  Widget _buildIconRow({required Widget icon, required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.only(bottom: Sizes.paddingXsSize),
      width: double.infinity,
      child: Row(
        children: [
          icon,
          Expanded(
            child: Wrap(children: children),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routes.detailHotelRoute, arguments: id);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.radiusMdSize),
          color: ColorPalette.whiteColor,
        ),
        margin: EdgeInsets.only(bottom: Sizes.paddingLgSize),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: Sizes.paddingMdSize),
              width: double.infinity,
              height: 14.h,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Sizes.radiusMdSize),
                  bottomRight: Radius.circular(Sizes.radiusMdSize),
                ),
                child: imageUrl != null
                    ? CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        ImagePath.hotelThumbnail,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Sizes.paddingMdSize),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: Sizes.paddingXsSize),
                    child: Text(
                      name ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  _buildIconRow(
                    icon: Icon(
                      Icons.location_on,
                      color: ColorPalette.frolyColor,
                      size: Sizes.iconMdSize,
                    ),
                    children: [
                      Text(
                        address == null
                            ? '--'
                            : '$address${distance != null ? " - " : ""}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (distance != null)
                        Text(
                          '${distance! < 1000 ? '${(distance! * 1000).toStringAsFixed(1)} m' : '${distance!.toStringAsFixed(1)} km'} from destination',
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorPalette.fontGrayColor,
                                  ),
                        ),
                    ],
                  ),
                  _buildIconRow(
                    icon: Icon(
                      Icons.star,
                      color: ColorPalette.amberColor,
                      size: Sizes.iconMdSize,
                    ),
                    children: [
                      Text(
                        '${star?.toStringAsFixed(1) ?? 0} ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '(${numberReviewers ?? 0} reviewers)',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorPalette.fontGrayColor,
                            ),
                      ),
                    ],
                  ),
                  DashedDivider(
                    color: ColorPalette.mercuryGrayColor,
                    padding: EdgeInsets.only(bottom: Sizes.paddingXsSize),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${price ?? 0}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 0.8.h),
                            Text(
                              '/night',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: Sizes.fontXsSize,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          height: 6.5.h,
                          onPressed: () async {
                            final currentLocation =
                                await getIt<LocationRepository>()
                                    .getCurrentLocation();
                            printTest(
                                'Current location: ${currentLocation?.latitude}, ${currentLocation?.longitude}');
                            final targetLocation = await getIt<
                                    LocationRepository>()
                                .getNearestLocation(
                                    'Williams Avenue, Whitewater, Oregon, Ecuador');
                            printTest(
                                'Selected location: ${targetLocation?.latitude}, ${targetLocation?.longitude}');
                            final distance = calculateDistance(
                                currentLocation!, targetLocation!);
                            printTest('Distance: $distance km');
                          },
                          child: Text(
                            'Book a room',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: ColorPalette.whiteColor,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
