import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/data/models/user.dart';

abstract class BaseUserRepository {
  Future<void> addUser(UserModel user);
}

class UserRepository extends BaseUserRepository {
  late CollectionReference<UserModel> collection;

  UserRepository() {
    collection = FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) =>
              UserModel.fromDocumentSnapshot(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  @override
  Future<void> addUser(UserModel user) async {
    await collection.add(user);
  }
}
