import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/data/models/hotel.dart';
import 'package:travel_app/data/repository/hotel_repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:travel_app/utils/common_utils.dart';

part 'result_hotel_event.dart';
part 'result_hotel_state.dart';

class ResultHotelBloc extends Bloc<ResultHotelEvent, ResultHotelState> {
  static const int _rowsPerPage = 5;
  static const _throttleDuration = Duration(microseconds: 100);

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return ((events, mapper) =>
        droppable<E>().call(events.throttle(duration), mapper));
  }

  final HotelRepository hotelRepository;

  ResultHotelBloc({required this.hotelRepository})
      : super(ResultHotelInitial()) {
    on<ResultHotelFetched>(
      _onResultHotelFetched,
      transformer: throttleDroppable(_throttleDuration),
    );
  }

  Future<void> _onResultHotelFetched(
    ResultHotelFetched event,
    Emitter<ResultHotelState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == FetchStatus.initial) {
        final hotels = await hotelRepository.findAll(limit: _rowsPerPage);
        return emit(state.copyWith(
          status: FetchStatus.success,
          hotels: hotels,
          hasReachedMax: false,
        ));
      }
      final hotels = await hotelRepository.findAll(
          limit: _rowsPerPage,
          startAfterId: state.hotels.isNotEmpty ? state.hotels.last.id : null);
      emit(
        hotels.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: FetchStatus.success,
                hotels: List.of(state.hotels)..addAll(hotels),
                hasReachedMax: false,
              ),
      );
    } catch (e) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }
}
