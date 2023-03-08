import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DashedDivider extends StatelessWidget {
  const DashedDivider({
    Key? key,
    this.thickness,
    this.dashSize,
    this.color,
    this.padding,
  }) : super(key: key);
  final double? thickness;
  final double? dashSize;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = dashSize ?? 8.0;
        final dashHeight = thickness ?? 1.sp;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color ?? Colors.black),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
