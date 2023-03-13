import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/data/source/network/http_utils.dart';
import 'package:travel_app/routes/router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initSingletons() async {
  // Initialize services
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
  getIt.registerLazySingleton<AuthenticationUtils>(() => AuthenticationUtils());
  getIt.registerLazySingleton<FireStoreUtils>(() => FireStoreUtils());

  // Initialize blocs
  getIt.registerLazySingleton<CommonBloc>(() => CommonBloc());
}
