import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_app/constants/api.dart';
import 'package:travel_app/utils/common_utils.dart';
import 'firebase_options.dart';

Future<void> initFirebase() async {
  // Initial Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run connect to Firebase Emulator
  if (useEmulatorFirebase) {
    await _connectToFirebaseEmulator();
  }

  printTest('Firebase: initialized Firebase');
}

Future _connectToFirebaseEmulator() async {
  FirebaseFirestore.instance.useFirestoreEmulator(apiUrl, fireStoreApiPort);
  FirebaseFirestore.instance.settings = const Settings(
    sslEnabled: false,
    persistenceEnabled: true,
  );
  await FirebaseAuth.instance.useAuthEmulator(apiUrl, authenticationApiPort);
  printTest('Firebase: using Firebase Emulator');
}
