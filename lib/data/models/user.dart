import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? photoURL;
  final String? displayName;

  const User({required this.id, this.email, this.photoURL, this.displayName});

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, email, photoURL, displayName];
}
