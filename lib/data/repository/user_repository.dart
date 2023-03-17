import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final CollectionReference _userCollectionReference;

  UserRepository({
    CollectionReference? userCollectionReference,
  }) : _userCollectionReference = userCollectionReference ??
            FirebaseFirestore.instance.collection('users');

  Future<void> getCurrentData(String documentId) async {
    try {
      _userCollectionReference.doc(documentId).get();
    } catch (_) {}
  }
}
