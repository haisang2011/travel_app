// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/bloc/common_bloc/authentication/authentication_repository.dart';

// import 'package:travel_app/data/models/user.dart';
import '../../../data/models/user.dart';

part 'authentication_status_enum.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User>? _userSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(
                  authenticationRepository.currentUser)
              : const AuthenticationState.unauthenticated(),
        ) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    // _authenticationStatusSubscription = _authenticationRepository.status.listen((status) => add(_AuthenticationStatusChanged(status)));
  }

  void _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) {
    emit(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated());
  }

  void _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_authenticationRepository.logout());
  }
}
