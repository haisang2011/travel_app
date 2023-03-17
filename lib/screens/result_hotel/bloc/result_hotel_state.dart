part of 'result_hotel_bloc.dart';

enum FetchStatus { initial, success, failure }

class ResultHotelState extends Equatable {
  final FetchStatus status;
  final List<Hotel> hotels;
  final bool hasReachedMax;
  final Location? currentLocation;

  const ResultHotelState({
    this.status = FetchStatus.initial,
    this.hotels = const <Hotel>[],
    this.hasReachedMax = false,
    this.currentLocation,
  });

  ResultHotelState copyWith({
    FetchStatus? status,
    List<Hotel>? hotels,
    bool? hasReachedMax,
    Location? currentLocation,
  }) {
    return ResultHotelState(
      status: status ?? this.status,
      hotels: hotels ?? this.hotels,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  @override
  String toString() {
    return '''ResultHotelState { status: $status, hasReachedMax: $hasReachedMax, hotels: ${hotels.length}, currentLocation: ${currentLocation != null ? '${currentLocation!.latitude}, ${currentLocation!.longitude}' : null} }''';
  }

  @override
  List<Object> get props => [status, hotels, hasReachedMax];
}

class ResultHotelInitial extends ResultHotelState {}
