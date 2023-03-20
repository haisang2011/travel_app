part of 'search_hotel_bloc.dart';

class SearchHotelState extends Equatable {
  final PickerDateRange? dateRange;
  final int numberOfGuests;
  final int numberOfRooms;

  const SearchHotelState({
    this.dateRange,
    this.numberOfGuests = 1,
    this.numberOfRooms = 1,
  });

  SearchHotelState copyWith({
    PickerDateRange? dateRange,
    int? numberOfGuests,
    int? numberOfRooms,
  }) {
    return SearchHotelState(
      dateRange: dateRange ?? this.dateRange,
      numberOfGuests: numberOfGuests ?? this.numberOfGuests,
      numberOfRooms: numberOfRooms ?? this.numberOfRooms,
    );
  }

  @override
  String toString() {
    return '''SearchHotelState { dateRange: ${dateRange?.startDate}-${dateRange?.endDate}, numberGuests: $numberOfGuests, numberRooms: $numberOfRooms }''';
  }

  @override
  List<Object> get props => [dateRange ?? '', numberOfGuests, numberOfRooms];
}
