import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:travel_app/data/di/config.dart';
import 'package:travel_app/data/dto/input_user_data.dart';
import 'package:travel_app/data/models/user.dart';
import 'package:travel_app/data/repository/base_authentication_repository.dart';
import 'package:travel_app/data/repository/user_repository.dart';
import 'package:travel_app/utils/common_utils.dart';

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(
        id: uid, email: email, displayName: displayName, photoURL: photoURL);
  }
}

class AuthenticationRepository implements BaseAuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  final firebase_firestore.FirebaseFirestore _firebaseFirestore =
      firebase_firestore.FirebaseFirestore.instance;

  final UserRepository userRepository = getIt<UserRepository>();

  AuthenticationRepository();

  @override
  Stream<UserModel> getCurrentUser() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser != null
          ? UserModel(id: firebaseUser.uid, email: firebaseUser.email)
          : UserModel.empty;
      return user;
    });
  }

  @override
  Future<Map<String, dynamic>?> retrieveUserData({required String id}) async {
    firebase_firestore.QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firebaseFirestore
            .collection(UserModel.collectionName)
            .where('id', isEqualTo: id)
            .get();
    return snapshot.docs.first.data();
  }

  @override
  Future<firebase_auth.UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      firebase_auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw firebase_auth.FirebaseAuthException(
          code: e.code, message: e.message);
    }
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<firebase_auth.UserCredential?> signUp(InputUserData input) async {
    try {
      firebase_auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: input.email!, password: input.password!);

      UserModel newUser = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email,
        displayName: input.displayName,
        phoneNumber: input.phoneNumber,
      );
      await userRepository.addUser(newUser);

      return userCredential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw firebase_auth.FirebaseAuthException(
          code: e.code, message: e.message);
    }
  }

  Future<void> resetPassword() async {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '84375376508',
      verificationCompleted: (firebase_auth.PhoneAuthCredential credential) {
        printTest('---START verificationCompleted---');
        inspect(credential);
        printTest('---END verificationCompleted---');
      },
      verificationFailed: (firebase_auth.FirebaseAuthException e) {
        printTest('---START verificationFailed---');
        inspect(e);
        printTest('---END verificationFailed---');
      },
      codeSent: (String verificationId, int? resendToken) {
        printTest('---START codeSent---');
        inspect(verificationId);
        printTest('---END codeSent---');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        printTest('---START codeAutoRetrievalTimeout---');
        inspect(verificationId);
        printTest('---END codeAutoRetrievalTimeout---');
      },
    );
  }
}
