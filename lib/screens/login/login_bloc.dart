import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/bloc/common_bloc/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_enum.dart';
part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authRepository;

  LoginBloc({
    required AuthenticationRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginState.initial()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    inspect(event);
    inspect(emit);
    emit(state.copyWith(email: event.email));
  }

  void _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  /* 
    Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await AuthenticationUtils()
          .signInWithEmailAndPassword(
              email: _emailEditingController.text,
              password: _passwordEditingController.text);
      inspect(userCredential);
    } on FirebaseAuthException catch (e) {
      inspect(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }
   */

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.submitting));

    try {
      // Using Future.delayed to test status
      await Future.delayed(
        const Duration(seconds: 2),
        () {
          _authRepository.logInWithEmailAndPassword(
            email: state.email,
            password: state.password,
          );
        },
      );

      emit(state.copyWith(status: LoginStatus.success));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
