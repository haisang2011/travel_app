import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/utils/common_utils.dart';

void importFirebaseFromJson(String inputFilePath, String collectionName) async {
  var input = await rootBundle.loadString(inputFilePath);
  var docs = jsonDecode(input);
  var successCount = 0;
  for (final doc in docs) {
    await FirebaseFirestore.instance.collection(collectionName).add(doc).then(
      (docRef) {
        printTest(
            '$successCount: Inserted a new "$collectionName" with ID: ${docRef.id}');
        successCount++;
      },
    );
  }
  printTest('Import success $successCount/${docs.length} records');
}
