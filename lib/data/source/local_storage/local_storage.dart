import 'package:travel_app/data/source/local_storage/cache_keys.dart';
import 'package:travel_app/utils/common_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _sharedPreferences;

  Future<SharedPreferences> initSharedPreferences() async {
    printTest('LocalStorage: initialized SharedPreferences');
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool>? clearShared() {
    return _sharedPreferences.clear();
  }

  void putBoolean({
    required CacheKey key,
    required bool value,
  }) async {
    await _sharedPreferences.setBool(key.name, value);
  }

  bool? getBoolean({required CacheKey key}) {
    return _sharedPreferences.getBool(key.name);
  }

  void putString({
    required CacheKey key,
    required String value,
  }) async {
    await _sharedPreferences.setString(key.name, value);
  }

  String? getString({required CacheKey key}) {
    return _sharedPreferences.getString(key.name);
  }

  void remove({required CacheKey key}) async {
    await _sharedPreferences.remove(key.name);
  }
}
