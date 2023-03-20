import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/data/dto/input_user_data.dart';
import 'package:travel_app/data/models/user.dart';

abstract class BaseAuthenticationRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp(InputUserData input);
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<Map<String, dynamic>?> retrieveUserData({
    required String id,
  });
}
