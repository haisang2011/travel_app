part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpNameChanged extends SignUpEvent {
  final String name;

  const SignUpNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class SignUpPhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  const SignUpPhoneNumberChanged({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();

  @override
  List<Object> get props => [];
}
