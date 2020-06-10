import 'package:cloud_firestore/cloud_firestore.dart';

class BatchList {
  getBatch(String batch) {
    return Firestore.instance
        .collection('students')
        .where('batch', isEqualTo: batch)
        .getDocuments();
  }
  /* var dr = ;*/
}
