part of 'result_hotel_bloc.dart';

enum FetchStatus { initial, success, failure }

class ResultHotelState extends Equatable {
  final FetchStatus status;
  final List<Hotel> hotels;
  final bool hasReachedMax;

  const ResultHotelState({
    this.status = FetchStatus.initial,
    this.hotels = const <Hotel>[],
    this.hasReachedMax = false,
  });

  ResultHotelState copyWith({
    FetchStatus? status,
    List<Hotel>? hotels,
    bool? hasReachedMax,
  }) {
    return ResultHotelState(
      status: status ?? this.status,
      hotels: hotels ?? this.hotels,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ResultHotelState { status: $status, hasReachedMax: $hasReachedMax, hotels: ${hotels.length} }''';
  }

  @override
  List<Object> get props => [status, hotels, hasReachedMax];
}

class ResultHotelInitial extends ResultHotelState {}
