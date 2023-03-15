part of 'common_bloc.dart';

enum AuthenticationStatusEnum { unknown, authenticated, unauthenticated }

abstract class CommonState extends Equatable {
  const CommonState();

  @override
  List<Object?> get props => [];
}

class AuthenticationState extends CommonState {
  final AuthenticationStatusEnum status;
  final User user;

  const AuthenticationState._({
    this.status = AuthenticationStatusEnum.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatusEnum.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatusEnum.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
