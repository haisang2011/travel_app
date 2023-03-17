import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/dismension.dart';

class BottomLoadingTile extends StatelessWidget {
  final double? height;

  const BottomLoadingTile({
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 10.h,
      padding: EdgeInsets.all(Sizes.paddingLgSize),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
