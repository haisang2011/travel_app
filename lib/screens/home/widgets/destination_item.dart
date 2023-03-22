import 'package:flutter/material.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/data/models/destination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletons/skeletons.dart';

class DestinationItem extends StatelessWidget {
  final Destination item;

  const DestinationItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: item.photo != null
                ? CachedNetworkImage(
                    imageUrl: item.photo!,
                  )
                : Image.asset(ImagePath.imageDestinationThumbnail)),
        Positioned(
            left: 10,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? '',
                  style: const TextStyle(
                      color: ColorPalette.whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: ColorPalette.whiteColor.withOpacity(0.4),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidStar,
                        color: ColorPalette.yellowColor,
                        size: 12.sp,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('${item.rating}'),
                    ],
                  ),
                ),
              ],
            )),
        Positioned(
            right: 10,
            top: 10,
            child: Icon(
              item.like! ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              color: ColorPalette.redColor,
            ))
      ],
    );
  }
}
