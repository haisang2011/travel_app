import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/bloc/common_bloc/authentication/authentication_bloc.dart';
import 'package:travel_app/bloc/common_bloc/authentication/authentication_repository.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/bloc/observer.dart';
import 'package:travel_app/constants/api.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/repository/hotel_repository.dart';
import 'package:travel_app/data/source/firebase/config.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/data/source/firebase/http_overrides.dart';
import 'package:travel_app/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/screens/login/login_bloc.dart';
import 'package:travel_app/themes/default.dart';
import 'package:travel_app/utils/common_utils.dart';

import 'data/source/firebase/firebase_options.dart';

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

  // Init Singletons with getIt
  initSingletons();

  // Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run connect to Firebase Emulator
  if (useEmulatorFirebase) {
    __configureFirebaseFirestore();
    await _configureFirebaseAuth();
  }

  // Init LocalStorage with SharedPreferences
  await getIt<LocalStorage>().initSharedPreferences();

  final authenticationRepository = AuthenticationRepository();

  // Set PreferredOrientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(App(
      authRepository: authenticationRepository,
    )),
  );
}

Future _configureFirebaseAuth() async {
  await FirebaseAuth.instance.useAuthEmulator(apiUrl, authenticationApiPort);
  debugPrint('Using Firebase Auth emulator on: $apiUrl:$authenticationApiPort');
}

void __configureFirebaseFirestore() {
  FirebaseFirestore.instance.settings = Settings(
    host: '$apiUrl:$fireStoreApiPort',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  debugPrint('Using Firebase Firestore emulator on: $apiUrl:$fireStoreApiPort');
}

class App extends StatelessWidget {
  const App({Key? key, required AuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  final AuthenticationRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<CommonBloc>()),
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authRepository,
            ),
          ),
          BlocProvider(
            create: (_) => LoginBloc(
              authRepository: _authRepository,
            ),
          ),
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
      ),
    );
  }
}
