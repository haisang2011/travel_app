import 'package:flutter/material.dart';
import 'package:travel_app/screens/search_hotel/widgets/icon_tile.dart';
import 'package:travel_app/screens/search_hotel/widgets/number_selector.dart';

class NumberSelectTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final void Function(int)? onValueChanged;
  final String title;

  const NumberSelectTile(
      {required this.icon,
      required this.iconColor,
      required this.title,
      this.onValueChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return IconTile(
      icon: icon,
      iconColor: iconColor,
      trailing: NumberSelector(
        onValueChanged: onValueChanged,
        min: 1,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
