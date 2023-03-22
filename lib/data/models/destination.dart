import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Destination extends Equatable {
  static const collectName = 'destination';
  final String id;
  final String? name;
  final num? rating;
  final bool? like;
  final String? description;
  final String? photo;

  const Destination({
    required this.id,
    this.name,
    this.rating = 0,
    this.like = false,
    this.description,
    this.photo,
  });

  Destination.fromJson(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["destination_name"],
        rating = doc.data()!["destination_rating"],
        like = doc.data()!["destination_like"],
        photo = doc.data()!["destination_photo"],
        description = doc.data()!["destination_desc"];

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'destination_name': name,
      'destination_photo': photo,
      'destination_like': like,
      'destination_desc': description,
      'destination_rating': rating,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        rating,
        like,
        description,
        photo,
      ];
}
