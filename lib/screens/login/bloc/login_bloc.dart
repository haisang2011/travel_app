import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/constants/auth_error_code.dart';
import 'package:travel_app/data/models/user.dart';
import 'package:travel_app/data/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_enum.dart';
part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginBloc({
    required this.authenticationRepository,
  }) : super(LoginState.initial()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await authenticationRepository.signIn(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: error.message,
      ));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
