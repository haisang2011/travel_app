import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/data/models/user.dart';
import 'package:travel_app/data/repository/authentication_repository.dart';
part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  final AuthenticationRepository authenticationRepository;
  StreamSubscription<User>? _userSubscription;

  CommonBloc({required this.authenticationRepository})
      : super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  void _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event, Emitter<CommonState> emit) {
    emit(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated());
  }

  void _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event, Emitter<CommonState> emit) {
    unawaited(authenticationRepository.logout());
  }
}
