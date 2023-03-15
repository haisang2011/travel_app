import 'dart:io';
import 'package:flutter/services.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/bloc/observer.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/repository/hotel_repository.dart';
import 'package:travel_app/data/source/firebase/config.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/data/source/firebase/http_overrides.dart';
import 'package:travel_app/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/themes/default.dart';
import 'package:travel_app/utils/common_utils.dart';

void main() async {
  HttpOverrides.global = AppHttpOverrides();
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  // Init firebase
  await initFirebase();

  // Init singleton services
  await initSingletons(); // firebase must be initialized before services

  // Init local storage
  await getIt<LocalStorage>().initSharedPreferences();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CommonBloc>()),
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
