part of 'common_bloc.dart';

abstract class CommonEvent {}

class _AuthenticationStatusChanged extends CommonEvent {
  _AuthenticationStatusChanged(this.user);
  final UserModel user;
}

class AuthenticationLogoutRequested extends CommonEvent {}
