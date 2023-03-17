part of 'search_hotel_bloc.dart';

abstract class SearchHotelEvent extends Equatable {
  const SearchHotelEvent();

  @override
  List<Object> get props => [];
}

class DateRangeChanged extends SearchHotelEvent {
  final PickerDateRange dateRange;

  const DateRangeChanged({required this.dateRange});
}

class GuestAndRoomChanged extends SearchHotelEvent {
  const GuestAndRoomChanged({required this.nbGuests, required this.nbRooms});
  final int nbGuests;
  final int nbRooms;
}
