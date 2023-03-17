import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_app/data/models/hotel.dart';
import 'package:travel_app/data/repository/hotel_repository.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:travel_app/data/repository/location_repository.dart';
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
  final LocationRepository locationRepository;

  ResultHotelBloc({
    required this.hotelRepository,
    required this.locationRepository,
  }) : super(ResultHotelInitial()) {
    on<ResultHotelFetched>(
      _onResultHotelFetched,
      transformer: throttleDroppable(_throttleDuration),
    );
  }

  Future<List<Hotel>> _hotelsWithLocation({String? startAfterId}) async {
    final hotels = await hotelRepository.findAll(
        limit: _rowsPerPage, startAfterId: startAfterId);
    final result = <Hotel>[];
    for (final hotel in hotels) {
      if (hotel.location == null && hotel.address != null) {
        result.add(hotel.copyWith(
            location:
                await locationRepository.getNearestLocation(hotel.address!)));
      }
    }
    return result;
  }

  Future<void> _onResultHotelFetched(
    ResultHotelFetched event,
    Emitter<ResultHotelState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      final currentLocation = await locationRepository.getCurrentLocation();
      if (state.status == FetchStatus.initial) {
        final hotels = await _hotelsWithLocation();
        return emit(state.copyWith(
          status: FetchStatus.success,
          hotels: hotels,
          hasReachedMax: false,
          currentLocation: currentLocation,
        ));
      }
      final hotels =
          await _hotelsWithLocation(startAfterId: state.hotels.last.id);
      emit(
        hotels.isEmpty
            ? state.copyWith(
                hasReachedMax: true,
                currentLocation: currentLocation,
              )
            : state.copyWith(
                status: FetchStatus.success,
                hotels: List.of(state.hotels)..addAll(hotels),
                hasReachedMax: false,
                currentLocation: currentLocation,
              ),
      );
    } catch (e) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }
}
