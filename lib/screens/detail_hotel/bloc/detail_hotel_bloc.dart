import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/data/models/hotel.dart';
import 'package:travel_app/data/repository/hotel_repository.dart';

part 'detail_hotel_event.dart';
part 'detail_hotel_state.dart';

class DetailHotelBloc extends Bloc<DetailHotelEvent, DetailHotelState> {
  final HotelRepository hotelRepository;

  DetailHotelBloc({required this.hotelRepository})
      : super(DetailHotelInitial()) {
    on<DetailHotelFetched>(_onDetailHotelFetched);
  }

  void _onDetailHotelFetched(
    DetailHotelFetched event,
    Emitter<DetailHotelState> emit,
  ) async {
    try {
      emit(GettingDetailHotel());
      final hotel = await hotelRepository.findById(id: event.id);
      emit(GetDetailHotelSuccess(hotel: hotel!));
    } on FirebaseException catch (e) {
      emit(GetDetailHotelFailure(errorMessage: e.message!));
    } catch (e) {
      emit(const GetDetailHotelFailure(
          errorMessage: 'Error occurs when getting hotel information'));
    }
  }
}
