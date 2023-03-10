import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';
import 'package:travel_app/widgets/app_header.dart';
import 'package:travel_app/widgets/custom_button.dart';
import 'package:travel_app/routes/routes.dart' as routes;

class SelectDateScreen extends StatelessWidget {
  const SelectDateScreen({super.key});

  void _onSelectionChanged(args) {
    print(args);
  }

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      leadingIcon: Icons.arrow_back,
      onPressedLeading: () {
        Navigator.of(context).pop();
      },
      title: 'Select date',
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.paddingLgSize,
            ),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  view: DateRangePickerView.month,
                  monthViewSettings:
                      const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  selectionColor: ColorPalette.atomicTangerineColor,
                  startRangeSelectionColor: ColorPalette.atomicTangerineColor,
                  endRangeSelectionColor: ColorPalette.atomicTangerineColor,
                  rangeSelectionColor:
                      ColorPalette.atomicTangerineColor.withOpacity(0.25),
                  todayHighlightColor: ColorPalette.atomicTangerineColor,
                  selectionMode: DateRangePickerSelectionMode.range,
                  toggleDaySelection: true,
                  selectionTextStyle:
                      Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                  selectionShape: DateRangePickerSelectionShape.circle,
                  showNavigationArrow: true,
                  initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(
                      const Duration(days: 3),
                    ),
                  ),
                ),
                CustomButton(
                  height: 6.5.h,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Select',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorPalette.whiteColor,
                        ),
                  ),
                ),
                SizedBox(height: 2.h),
                CustomButton(
                  height: 6.5.h,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  opacity: 0.1,
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorPalette.indigoColor,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
