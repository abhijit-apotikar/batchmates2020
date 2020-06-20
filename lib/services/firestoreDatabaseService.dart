import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/authService.dart';

class FirestoreDatabaseService {
  AuthService _auth = new AuthService();

//increase student count in batch info files---------
  void _increaseBatchSCount(String batch, String gender) async {
    DocumentReference dr = Firestore.instance.document('/batches/$batch');
    DocumentSnapshot ds = await dr.get();
    var currStrength = ds['strength'];
    var currBoys = ds['boys'];
    var currGirls = ds['girls'];
    bool isEntryBoy = gender == 'male' ? true : false;
    if (isEntryBoy) {
      dr.updateData({
        'strength': currStrength + 1,
        'boys': currBoys + 1,
      });
    } else {
      dr.updateData({
        'strength': currStrength + 1,
        'girls': currGirls + 1,
      });
    }
  }

  //increase student count in batch info files---------
  void _decreaseBatchSCount(String batch, String gender) async {
    DocumentReference dr = Firestore.instance.document('/batches/$batch');
    DocumentSnapshot ds = await dr.get();
    var currStrength = ds['strength'];
    var currBoys = ds['boys'];
    var currGirls = ds['girls'];
    bool isEntryBoy = gender == 'male' ? true : false;
    if (isEntryBoy) {
      dr.updateData({
        'strength': currStrength - 1,
        'boys': currBoys - 1,
      });
    } else {
      dr.updateData({
        'strength': currStrength - 1,
        'girls': currGirls - 1,
      });
    }
  }

//check if student exists----------------
  Future<bool> _checkStudent(String fName, String lName) async {
    int flag = 0;
    QuerySnapshot qs =
        await Firestore.instance.collection('students').getDocuments();

    for (int i = 0; i < qs.documents.length; i++) {
      if ((qs.documents[i].data['fName'] == fName) &&
          (qs.documents[i].data['lName'] == lName)) {
        flag = 1;
        break;
      }
    }
    if (flag == 0)
      return false;
    else
      return true;
  }

//add student-----------------------------
  Future<bool> addStudent(
      String fName, String lName, String batch, String gender) async {
    bool exists = await _checkStudent(fName, lName);
    if (exists) {
      return false;
    } else {
      CollectionReference cr = Firestore.instance.collection('students');

      cr.add({
        'fName': fName,
        'lName': lName,
        'batch': batch,
        'gender': gender,
      });
      _increaseBatchSCount(batch, gender);
      return true;
    }
  }

//delete student-----------------------------
  Future<bool> deleteStudent(
      String fName, String lName, String batch, String gender) async {
    bool exists = await _checkStudent(fName, lName);
    if (exists) {
      CollectionReference cr = Firestore.instance.collection('students');
      QuerySnapshot qs = await cr
          .where('fName', isEqualTo: fName)
          .where('lName', isEqualTo: lName)
          .where('batch', isEqualTo: batch)
          .where('gender', isEqualTo: gender)
          .getDocuments();
      List<String> rec = [];
      qs.documents.forEach((element) {
        rec.add(element.documentID);
      });
      for (int i = 0; i < rec.length; i++) {
        cr.document(rec[i]).delete();
      }
      _decreaseBatchSCount(batch, gender);
      return true;
    } else {
      return false;
    }
  }

//check if result already exists-------------------
  Future<bool> _checkResult(String fName, String lName, String examName) async {
    int flag = 0;
    QuerySnapshot qs =
        await Firestore.instance.collection('$examName').getDocuments();

    for (int i = 0; i < qs.documents.length; i++) {
      if ((qs.documents[i].data['${examName}_fName'] == fName) &&
          (qs.documents[i].data['${examName}_lName'] == lName)) {
        flag = 1;
        break;
      }
    }
    if (flag == 0)
      return false;
    else
      return true;
  }

  //add single result---------------------
  Future<bool> addResult(
      String fName, String lName, String batch, String examName) async {
    bool exists = await _checkResult(fName, lName, examName);
    if (exists) {
      return false;
    } else {
      CollectionReference cr = Firestore.instance.collection('$examName');
      switch (batch) {
        case 'm1':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'comp': {
              'compInt': null,
              'compTh': null,
              'compPract': null,
            },
            'maths': {
              'mahts1Int': null,
              'maths1Th': null,
              'maths2Int': null,
              'maths2Th': null,
            },
            'stat': {
              'statInt': null,
              'statTh': null,
              'statPract': null,
            }
          });
          break;

        case 'm2':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'comp': {
              'compInt': null,
              'compTh': null,
              'compPract': null,
            },
            'maths': {
              'mahts1Int': null,
              'maths1Th': null,
              'maths2Int': null,
              'maths2Th': null,
            },
            'phy': {
              'phyInt': null,
              'phyTh': null,
              'phyPract': null,
            }
          });
          break;

        case 'm3':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'phy': {
              'phyInt': null,
              'phyTh': null,
              'phyPract': null,
            },
            'elec': {
              'elecInt': null,
              'elecTh': null,
              'elecPract': null,
            },
            'comp': {
              'compInt': null,
              'compTh': null,
              'compPract': null,
            },
          });
          break;

        case 'm4':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'stat': {
              'statInt': null,
              'statTh': null,
              'statPract': null,
            },
            'elec': {
              'elecInt': null,
              'elecTh': null,
              'elecPract': null,
            },
            'comp': {
              'compInt': null,
              'compTh': null,
              'compPract': null,
            },
          });
          break;

        case 'm5':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'phy': {
              'phyInt': null,
              'phyTh': null,
              'phyPract': null,
            },
            'chem': {
              'chemInt': null,
              'chemTh': null,
              'chemPract': null,
            },
            'comp': {
              'compInt': null,
              'compTh': null,
              'compPract': null,
            },
          });
          break;

        case 'm6':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'phy': {
              'phyInt': null,
              'phyTh': null,
              'phyPract': null,
            },
            'maths': {
              'mahts1Int': null,
              'maths1Th': null,
              'maths2Int': null,
              'maths2Th': null,
            },
            'elec': {
              'elecInt': null,
              'elecTh': null,
              'elecPract': null,
            },
          });
          break;

        case 'm7':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'phy': {
              'phyInt': null,
              'phyTh': null,
              'phyPract': null,
            },
            'chem': {
              'chemInt': null,
              'chemTh': null,
              'chemPract': null,
            },
            'maths': {
              'mahts1Int': null,
              'maths1Th': null,
              'maths2Int': null,
              'maths2Th': null,
            },
          });
          break;
      }

      return true;
    }
  }

  //delete single result-----------
  Future<bool> deleteResult(String fName, String lName, String examName) async {
    bool exists = await _checkResult(fName, lName, examName);
    if (exists) {
      CollectionReference cr = Firestore.instance.collection('$examName');
      QuerySnapshot qs = await cr
          .where('${examName}_fName', isEqualTo: fName)
          .where('${examName}_lName', isEqualTo: lName)
          .getDocuments();
      List<String> rec = [];
      qs.documents.forEach((element) {
        rec.add(element.documentID);
      });
      for (int i = 0; i < rec.length; i++) {
        cr.document(rec[i]).delete();
      }

      return true;
    } else {
      return false;
    }
  }

  //get Student record----------------
  Future getStudentRecord(String fName, String lName) async {
    QuerySnapshot qs = await Firestore.instance
        .collection('students')
        .where(
          'fName',
          isEqualTo: fName,
        )
        .where('lName', isEqualTo: lName)
        .getDocuments();
    if (qs.documents.isNotEmpty) {
      return qs.documents[0];
    } else {
      return null;
    }
  }

  //update student record-----------
  Future<bool> updateStudentRecord(
      String documentID, fName, lName, batch, gender) async {
    try {
     DocumentReference dr = Firestore.instance
          .collection('students')
          .document(documentID);
        await dr.updateData({
        'fName': fName,
        'lName': lName,
        'batch': batch,
        'gender': gender,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
