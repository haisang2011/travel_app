import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/data/models/hotel.dart';

class HotelRepository {
  late CollectionReference<Hotel> collection;

  HotelRepository() {
    collection = FirebaseFirestore.instance
        .collection(Hotel.collectionName)
        .withConverter(
          fromFirestore: (snapshot, _) => Hotel.fromJson({
            'id': snapshot.id,
            ...snapshot.data()!,
          }),
          toFirestore: (hotel, _) => hotel.toJson(),
        );
  }

  Future<List<Hotel>> findAll({
    int? limit,
    String? startAfterId,
  }) async {
    Query<Hotel> query = collection.orderBy(FieldPath.documentId);
    if (limit != null) {
      query = query.limit(limit);
    }
    if (startAfterId != null) {
      query = query.startAt([startAfterId]);
    }
    await Future.delayed(const Duration(seconds: 2));
    return query.get().then(
        (queryResult) => queryResult.docs.map((doc) => doc.data()).toList());
  }

  Future<Hotel?> findById({required String id}) async {
    return collection.doc(id).get().then(
          (snapshot) => snapshot.data(),
        );
  }
}
