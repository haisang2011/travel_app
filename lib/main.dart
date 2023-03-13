import 'dart:io';

import 'package:flutter/services.dart';
import 'package:travel_app/bloc/common_bloc/common_bloc.dart';
import 'package:travel_app/bloc/observer.dart';
import 'package:travel_app/constants/api.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/data/source/network/http_overrides.dart';
import 'package:travel_app/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_app/themes/default.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  HttpOverrides.global = AppHttpOverrides();
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  initSingletons();

  // Initial Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run connect to Firebase Emulator
  if (useEmulatorFirebase) {
    await _connectToFirebaseEmulator();
  }

  await getIt<LocalStorage>().initSharedPreferences();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const App()),
  );
}

Future _connectToFirebaseEmulator() async {
  FirebaseFirestore.instance.settings = const Settings(
    host: '$apiUrl:$fireStoreApiPort',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  await FirebaseAuth.instance.useAuthEmulator(apiUrl, authenticationApiPort);
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
