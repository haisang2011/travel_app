import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/data/models/hotel.dart';

class HotelRepository {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection(Hotel.collectionName);

  Future<List<Hotel>> getData({
    int? limit,
    DocumentSnapshot? lastDocument,
  }) async {
    Query<Map<String, dynamic>> query =
        collection.orderBy(HotelColumn.name.columnName);
    if (limit != null) {
      query = query.limit(limit);
    }
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }
    return query.get().then(
        (QuerySnapshot<Map<String, dynamic>> collectionSnapshot) =>
            Future<List<Hotel>>.value(collectionSnapshot.docs
                .map((doc) => Hotel.fromJson(doc.data()))
                .toList()));
  }
}
