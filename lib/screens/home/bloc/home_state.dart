// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum FetchStatus { idle, pending, success, failure }

class HomeState extends Equatable {
  final FetchStatus status;
  final List<Destination> destinations;

  const HomeState({
    this.status = FetchStatus.idle,
    this.destinations = const [],
  });

  factory HomeState.initial() {
    return const HomeState();
  }

  @override
  List<Object> get props => [status, destinations];

  HomeState copyWith({
    FetchStatus? status,
    List<Destination>? destinations,
  }) {
    return HomeState(
      status: status ?? this.status,
      destinations: destinations ?? this.destinations,
    );
  }
}
