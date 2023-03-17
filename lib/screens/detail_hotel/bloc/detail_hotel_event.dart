part of 'detail_hotel_bloc.dart';

abstract class DetailHotelEvent extends Equatable {
  const DetailHotelEvent();

  @override
  List<Object> get props => [];
}

class DetailHotelFetched extends DetailHotelEvent {
  final String id;
  const DetailHotelFetched({required this.id});
}
