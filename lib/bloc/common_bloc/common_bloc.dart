import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/data/models/user.dart';
import 'package:travel_app/data/repository/authentication_repository.dart';
part 'common_event.dart';
part 'common_state.dart';

class CommonBloc extends Bloc<CommonEvent, CommonState> {
  final AuthenticationRepository authenticationRepository;
  late final StreamSubscription<UserModel>? _userSubscription;

  CommonBloc({required this.authenticationRepository})
      : super(const AuthenticationState.unauthenticated()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _userSubscription = authenticationRepository
        .getCurrentUser()
        .listen((user) => add(_AuthenticationStatusChanged(user)));
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<CommonState> emit,
  ) async {
    if (event.user.isEmpty) {
      emit(const AuthenticationState.unauthenticated());
    } else {
      Map<String, dynamic>? snapshot =
          await authenticationRepository.retrieveUserData(id: event.user.id);
      emit(
        AuthenticationState.authenticated(
          snapshot != null
              ? UserModel.fromDocumentSnapshot(snapshot)
              : event.user,
        ),
      );
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<CommonState> emit,
  ) {
    unawaited(authenticationRepository.signOut());
  }

  @override
  Future<void> close() {
    _userSubscription!.cancel();
    return super.close();
  }
}
