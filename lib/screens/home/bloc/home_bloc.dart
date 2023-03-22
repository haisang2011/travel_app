import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/data/models/destination.dart';
import 'package:travel_app/data/repository/destination_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DestinationRepository destinationRepository;

  HomeBloc({required this.destinationRepository}) : super(HomeState.initial()) {
    on<FetchDestinationData>(_onFetchDestinationData);
  }

  void _onFetchDestinationData(
    FetchDestinationData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: FetchStatus.pending));
    try {
      List<Destination>? destinations =
          await destinationRepository.getDestinationData();
      await Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(
          status: FetchStatus.success,
          destinations: destinations,
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        status: FetchStatus.failure,
        destinations: [],
      ));
    }
  }
}
