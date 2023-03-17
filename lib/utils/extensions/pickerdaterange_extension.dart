import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/utils/extensions/datetime_extension.dart';

extension PickerDateRangeExtension on PickerDateRange {
  bool equals(PickerDateRange? other) {
    if (other == null) return false;
    final isSameStartDate =
        startDate?.isSameDate(other.startDate) ?? other.startDate == null;
    final isSameEndDate =
        endDate?.isSameDate(other.endDate) ?? other.endDate == null;
    return isSameStartDate && isSameEndDate;
  }

  PickerDateRange clone() {
    return PickerDateRange(startDate, endDate);
  }
}
