part of 'detail_hotel_bloc.dart';

class DetailHotelState extends Equatable {
  const DetailHotelState();

  @override
  List<Object> get props => [];
}

class DetailHotelInitial extends DetailHotelState {}

class GettingDetailHotel extends DetailHotelState {}

class GetDetailHotelSuccess extends DetailHotelState {
  final Hotel hotel;

  const GetDetailHotelSuccess({required this.hotel});
}

class GetDetailHotelFailure extends DetailHotelState {
  final String errorMessage;

  const GetDetailHotelFailure({required this.errorMessage});
}
