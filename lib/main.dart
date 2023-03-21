import 'dart:io';
import 'package:flutter/services.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/bloc/observer.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/source/firebase/config.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/data/source/firebase/http_overrides.dart';
import 'package:travel_app/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/screens/detail_hotel/bloc/detail_hotel_bloc.dart';
import 'package:travel_app/screens/login/bloc/login_bloc.dart';
import 'package:travel_app/screens/signup/bloc/sign_up_bloc.dart';
import 'package:travel_app/screens/result_hotel/bloc/result_hotel_bloc.dart';
import 'package:travel_app/screens/search_hotel/bloc/search_hotel_bloc.dart';
import 'package:travel_app/themes/default.dart';
import 'package:travel_app/data/source/firebase/utils.dart';

void main() async {
  HttpOverrides.global = AppHttpOverrides();
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  // Init firebase
  await initFirebase();

  // Init singleton services
  await initSingletons(); // firebase must be initialized before services

  // Init LocalStorage with SharedPreferences
  await getIt<LocalStorage>().initSharedPreferences();

  // importFirebaseFromJson('assets/import_data/user.json', 'user');

  // Set PreferredOrientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const App()),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CommonBloc>()),
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<SignUpBloc>()),
        BlocProvider(create: (_) => getIt<ResultHotelBloc>()),
        BlocProvider(create: (_) => getIt<DetailHotelBloc>()),
        BlocProvider(create: (_) => getIt<SearchHotelBloc>())
      ],
      child: BlocBuilder<CommonBloc, CommonState>(
        builder: (context, state) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              theme: theme,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: getIt<AppRouter>().onGenerateRoute,
            );
          });
        },
      ),
    );
  }
}
