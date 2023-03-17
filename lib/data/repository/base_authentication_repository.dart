import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/data/models/user.dart';

abstract class BaseAuthenticationRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  });
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<Map<String, dynamic>?> retrieveUserData({
    required String id,
  });
}
