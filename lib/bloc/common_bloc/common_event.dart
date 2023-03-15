part of 'common_bloc.dart';

abstract class CommonEvent {}

class _AuthenticationStatusChanged extends CommonEvent {
  _AuthenticationStatusChanged(this.user);
  final User user;
}

class AuthenticationLogoutRequested extends CommonEvent {}
