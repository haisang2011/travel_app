import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/utils/extensions/pickerdaterange_extension.dart';

part 'search_hotel_event.dart';
part 'search_hotel_state.dart';

class SearchHotelBloc extends Bloc<SearchHotelEvent, SearchHotelState> {
  SearchHotelBloc() : super(const SearchHotelState()) {
    on<DateRangeChanged>(_onDateRangeChanged);
    on<GuestAndRoomChanged>(_onGuestAndRoomChanged);
  }

  void _onDateRangeChanged(
    DateRangeChanged event,
    Emitter<SearchHotelState> emit,
  ) {
    emit(state.copyWith(dateRange: event.dateRange.clone()));
  }

  void _onGuestAndRoomChanged(
    GuestAndRoomChanged event,
    Emitter<SearchHotelState> emit,
  ) {
    emit(state.copyWith(
      numberOfGuests: event.nbGuests,
      numberOfRooms: event.nbRooms,
    ));
  }
}
