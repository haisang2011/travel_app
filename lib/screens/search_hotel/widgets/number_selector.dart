import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/constants/colors.dart';
import 'package:travel_app/constants/dismension.dart';

class NumberSelector extends StatefulWidget {
  final void Function(int)? onValueChanged;
  final int? min;
  final int? max;
  final int? initialValue;

  const NumberSelector({
    this.onValueChanged,
    this.min,
    this.max,
    this.initialValue,
    super.key,
  });

  @override
  State<NumberSelector> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  var value = 0;

  @override
  void initState() {
    value = widget.initialValue ?? widget.min ?? 0;
    super.initState();
  }

  VoidCallback? get increaseHandler {
    if (widget.max != null && value == widget.max) {
      return null;
    }
    return () {
      setState(() {
        value += 1;
      });
      widget.onValueChanged?.call(value);
    };
  }

  VoidCallback? get decreaseHandler {
    if (widget.min != null && value == widget.min) {
      return null;
    }
    return () {
      setState(() {
        value -= 1;
      });
      widget.onValueChanged?.call(value);
    };
  }

  Widget _buildButton(bool isIncrement) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 10.w, height: 10.w),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: ColorPalette.greenColor,
          disabledBackgroundColor: ColorPalette.swansDownColor,
          foregroundColor: ColorPalette.whiteColor,
        ),
        onPressed: isIncrement ? increaseHandler : decreaseHandler,
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          size: Sizes.iconMdSize,
          color: ColorPalette.whiteColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton(false),
        SizedBox(width: 2.w),
        SizedBox(
          width: 8.w,
          child: Text(
            value.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: Sizes.fontLgSize,
                ),
          ),
        ),
        SizedBox(width: 2.w),
        _buildButton(true),
      ],
    );
  }
}
