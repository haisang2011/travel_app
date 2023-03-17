import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/data/repository/authentication_repository.dart';

part 'sign_up_enum.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository authenticationRepository;

  SignUpBloc({required this.authenticationRepository})
      : super(SignUpState.initial()) {
    on<SignUpEvent>(_onSignUpFieldChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpFieldChanged(SignUpEvent event, Emitter<SignUpState> emit) {
    if (event is SignUpNameChanged) {
      emit(state.copyWith(name: event.name));
    } else if (event is SignUpPhoneNumberChanged) {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    } else if (event is SignUpEmailChanged) {
      emit(state.copyWith(email: event.email));
    } else if (event is SignUpPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
  }

  void _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      // Using Future.delayed to test status
      await authenticationRepository.signUp(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: SignUpStatus.success));
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
        status: SignUpStatus.error,
        errorMessage: error.message,
      ));
    } catch (_) {
      emit(state.copyWith(status: SignUpStatus.error));
    }
  }
}
