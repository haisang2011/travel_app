part of 'search_hotel_bloc.dart';

class SearchHotelState extends Equatable {
  final Location? destination;
  final PickerDateRange? dateRange;
  final int numberOfGuests;
  final int numberOfRooms;

  const SearchHotelState({
    this.destination,
    this.dateRange,
    this.numberOfGuests = 1,
    this.numberOfRooms = 1,
  });

  SearchHotelState copyWith({
    Location? destination,
    PickerDateRange? dateRange,
    int? numberOfGuests,
    int? numberOfRooms,
  }) {
    return SearchHotelState(
      destination: destination ?? this.destination,
      dateRange: dateRange ?? this.dateRange,
      numberOfGuests: numberOfGuests ?? this.numberOfGuests,
      numberOfRooms: numberOfRooms ?? this.numberOfRooms,
    );
  }

  @override
  String toString() {
    return '''SearchHotelState { destination: ${destination?.latitude}, ${destination?.longitude}, dateRange: ${dateRange?.startDate}-${dateRange?.endDate}, numberGuests: $numberOfGuests, numberRooms: $numberOfRooms }''';
  }

  @override
  List<Object> get props =>
      [destination ?? '', dateRange ?? '', numberOfGuests, numberOfRooms];
}
