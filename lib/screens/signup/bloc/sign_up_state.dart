part of 'sign_up_bloc.dart';

class SignUpState {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final SignUpStatus status;
  final String? errorMessage;

  const SignUpState({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.status,
    this.errorMessage,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      name: '',
      phoneNumber: '',
      email: '',
      password: '',
      status: SignUpStatus.initial,
    );
  }

  SignUpState copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? password,
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, name, phoneNumber, status];
}
