part of 'common_bloc.dart';

enum AuthenticationStatusEnum { unknown, authenticated, unauthenticated }

abstract class CommonState extends Equatable {
  final AuthenticationStatusEnum status;
  final UserModel user;

  const CommonState._({
    this.status = AuthenticationStatusEnum.unauthenticated,
    this.user = UserModel.empty,
  });

  @override
  List<Object?> get props => [status, user];
}

class AuthenticationState extends CommonState {
  const AuthenticationState.unknown() : super._();

  const AuthenticationState.authenticated(UserModel user)
      : super._(user: user, status: AuthenticationStatusEnum.authenticated);

  const AuthenticationState.unauthenticated()
      : super._(status: AuthenticationStatusEnum.unauthenticated);
}
