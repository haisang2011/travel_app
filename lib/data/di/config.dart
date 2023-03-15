import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/data/repository/hotel_repository.dart';
import 'package:travel_app/routes/router.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_app/screens/result_hotel/bloc/result_hotel_bloc.dart';
import 'package:travel_app/utils/common_utils.dart';

final getIt = GetIt.instance;

Future<void> initSingletons() async {
  // Initialize services
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());

  // Initialize blocs
  getIt.registerLazySingleton<CommonBloc>(() => CommonBloc());
  getIt.registerLazySingleton<ResultHotelBloc>(() => ResultHotelBloc());

  // Initialize repository
  getIt.registerLazySingleton<HotelRepository>(() => HotelRepository());

  printTest('GetIt: initialized services');
}
