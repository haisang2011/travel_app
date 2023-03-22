import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/data/models/destination.dart';
import 'package:travel_app/utils/common_utils.dart';

abstract class BaseDestinationRepository {
  Future<void> getDestinationData();
}

class DestinationRepository implements BaseDestinationRepository {
  late CollectionReference<Destination> collection;

  DestinationRepository() {
    collection = FirebaseFirestore.instance
        .collection(Destination.collectName)
        .withConverter<Destination>(
          fromFirestore: (snapshot, _) => Destination.fromJson(snapshot),
          toFirestore: (destination, _) => destination.toJson(),
        );
  }

  @override
  Future<List<Destination>> getDestinationData() {
    return collection.get().then((queryResult) {
      List<Destination> destinationList =
          queryResult.docs.map((doc) => doc.data()).toList();
      return destinationList;
    }).catchError((_) {});
  }
}
