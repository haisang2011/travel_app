import 'package:flutter/foundation.dart';

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
