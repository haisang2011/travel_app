import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:stack_trace/stack_trace.dart' as stacktrace;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/models/user.dart';
import 'package:travel_app/data/source/local_storage/cache_keys.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/routes/routes.dart' as routes;

String _currentLoggingFilePath() {
  final fullPackagePath = stacktrace.Frame.caller(2).library;
  return fullPackagePath.substring(fullPackagePath.indexOf('/') + 1);
}

void printResponse(Object text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m -- File: ${_currentLoggingFilePath()}');
  }
}

void printError(Object text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m -- File: ${_currentLoggingFilePath()}');
  }
}

void printTest(Object text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m -- File: ${_currentLoggingFilePath()}');
  }
}

void saveAuthDataIntoLocalStorage() async {
  // UserCredential
  final userData = json.encode({
    'token': '',
  });
  // getIt<LocalStorage>().putString(key: 'userData', value: value)
}

void getAuthDataFromLocalStorage() async {}

void navigateNextScreenAfterAuthenticate(BuildContext context) {
  final bool? ignoreIntro =
      getIt<LocalStorage>().getBoolean(key: CacheKey.ignoreIntro);
  if (ignoreIntro != null && ignoreIntro) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routes.homeRoute, (route) => false);
  } else {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(routes.introduceRoute, (route) => false);
  }
}

double calculateDistance(Location source, Location target) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((target.latitude - source.latitude) * p) / 2 +
      cos(source.latitude * p) *
          cos(target.latitude * p) *
          (1 - cos((target.longitude - source.longitude) * p)) /
          2;
  return 12742 * asin(sqrt(a));
}

