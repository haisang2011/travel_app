import 'dart:io';

const String appName = "Travo";

const useEmulatorFirebase = true;
const String firebaseApiKey = '[API_KEY]';
final apiUrl = Platform.isAndroid ? '10.0.2.2' : 'localhost';
const int authenticationApiPort = 9099;
const int fireStoreApiPort = 8080;

const int apiConnectionTimeout = 30; // seconds
