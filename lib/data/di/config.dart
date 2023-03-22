import 'package:travel_app/data/repository/authentication_repository.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/data/repository/destination_repository.dart';
import 'package:travel_app/data/repository/user_repository.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/data/repository/hotel_repository.dart';
import 'package:travel_app/routes/router.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_app/screens/detail_hotel/bloc/detail_hotel_bloc.dart';
import 'package:travel_app/screens/home/bloc/home_bloc.dart';
import 'package:travel_app/screens/login/bloc/login_bloc.dart';
import 'package:travel_app/screens/result_hotel/bloc/result_hotel_bloc.dart';
import 'package:travel_app/screens/signup/bloc/sign_up_bloc.dart';
import 'package:travel_app/screens/search_hotel/bloc/search_hotel_bloc.dart';
import 'package:travel_app/utils/common_utils.dart';

final getIt = GetIt.instance;

Future<void> initSingletons() async {
  // Initialize services
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());

  // Initialize repository
  getIt.registerLazySingleton<HotelRepository>(() => HotelRepository());
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<DestinationRepository>(
      () => DestinationRepository());
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  // Initialize blocs
  getIt.registerLazySingleton<CommonBloc>(
    () => CommonBloc(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );
  getIt.registerLazySingleton<SearchHotelBloc>(
    () => SearchHotelBloc(),
  );
  getIt.registerLazySingleton<ResultHotelBloc>(
    () => ResultHotelBloc(
      hotelRepository: getIt<HotelRepository>(),
    ),
  );
  getIt.registerLazySingleton<DetailHotelBloc>(
    () => DetailHotelBloc(
      hotelRepository: getIt<HotelRepository>(),
    ),
  );
  getIt.registerLazySingleton<LoginBloc>(
    () => LoginBloc(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );
  getIt.registerLazySingleton<SignUpBloc>(
    () => SignUpBloc(
      authenticationRepository: getIt<AuthenticationRepository>(),
    ),
  );
  getIt.registerLazySingleton<HomeBloc>(
    () => HomeBloc(destinationRepository: getIt<DestinationRepository>()),
  );

  printTest('GetIt: initialized services');
}
