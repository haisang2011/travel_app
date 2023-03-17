import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/models/user.dart';
import 'package:travel_app/data/source/local_storage/cache_keys.dart';
import 'package:travel_app/data/source/local_storage/local_storage.dart';
import 'package:travel_app/routes/routes.dart' as routes;

void printResponse(Object text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printError(Object text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printTest(Object text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
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
