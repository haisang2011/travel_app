import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'result_hotel_event.dart';
part 'result_hotel_state.dart';

class ResultHotelBloc extends Bloc<ResultHotelEvent, ResultHotelState> {
  ResultHotelBloc() : super(ResultHotelInitial()) {
    on<ResultHotelEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
