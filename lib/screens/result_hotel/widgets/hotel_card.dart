import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/constants/images.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/widgets/dashed_divider.dart';
import 'package:travel_app/routes/routes.dart' as routes;

class HotelCard extends StatelessWidget {
  const HotelCard({super.key});

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
        Navigator.of(context).pushNamed(routes.detailHotelRoute);
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
                child: Image.asset(
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
                      'Royal Palm Heritage',
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
                        'Purwokerto, Jateng - ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '364 m from destination',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorPalette.fontGreyColor,
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
                        '4.5 ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '(3241 reviewers)',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorPalette.fontGreyColor,
                            ),
                      ),
                    ],
                  ),
                  DashedDivider(
                    color: ColorPalette.mercuryGreyColor,
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
                              '\$143',
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
                          onPressed: () {},
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
