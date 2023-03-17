import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  static const collectionName = 'user';
  final String id;
  final String? email;
  final String? photoURL;
  final String? displayName;
  final String? phoneNumber;

  const UserModel({
    required this.id,
    this.email,
    this.photoURL,
    this.displayName,
    this.phoneNumber,
  });

  UserModel.fromDocumentSnapshot(Map<String, dynamic>? doc)
      : id = doc!["id"],
        email = doc["email"],
        photoURL = doc["photoURL"],
        displayName = doc["displayName"],
        phoneNumber = doc["phoneNumber"];

  static const empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [id, email, photoURL, displayName, phoneNumber];
}
