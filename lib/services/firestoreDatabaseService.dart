import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseService {
  //Exam names---------------------
  List<String> examNames = [
    'bscSem1W2017',
    'bscSem2S2018',
    'bscSem3W2018',
    'bscSem4S2019',
    'bscSem5W2019',
  ];

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
   _decreaseBatchSCount(String batch, String gender) async {
    DocumentReference dr = Firestore.instance.document('/batches/$batch');
    DocumentSnapshot ds = await dr.get();
    var currStrength = ds['strength'];
    var currBoys = ds['boys'];
    var currGirls = ds['girls'];
    bool isEntryBoy = gender == 'male' ? true : false;
    if (isEntryBoy) {
      dr.updateData({
        'strength': currStrength == 0 ? currStrength : currStrength - 1,
        'boys': currBoys == 0 ? currBoys : currBoys - 1,
      });
    } else {
      dr.updateData({
        'strength': currStrength == 0 ? currStrength : currStrength - 1,
        'girls': currGirls == 0 ? currGirls : currGirls - 1,
      });
    }
  }

//check if student exists----------------
  Future<bool> _checkStudent(
    String fName,
    String lName,
  ) async {
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
  Future<dynamic> addStudent(
      String fName, String lName, String batch, String gender) async {
    bool exists = await _checkStudent(
      fName,
      lName,
    );
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

      for (int i = 0; i < examNames.length; i++) {
        QuerySnapshot qs = await Firestore.instance
            .collection('${examNames[i]}')
            .where('${examNames[i]}_fName', isEqualTo: fName)
            .where('${examNames[i]}_lName')
            .getDocuments();
        if (qs.documents.isEmpty) {
          await addResult(fName, lName, batch, examNames[i]);
        }
      }
      return true;
    }
  }

//delete student-----------------------------
  Future<bool> deleteStudent(
    String fName,
    String lName,
  ) async {
    bool exists = await _checkStudent(
      fName,
      lName,
    );
    if (exists) {
      CollectionReference cr = Firestore.instance.collection('students');
      QuerySnapshot qs = await cr
          .where('fName', isEqualTo: fName)
          .where('lName', isEqualTo: lName)
          .getDocuments();
      List<String> rec = [];
      qs.documents.forEach((element) {
        rec.add(element.documentID);
      });
      for (int i = 0; i < rec.length; i++) {
        DocumentSnapshot batchData = await cr.document(rec[i]).get();
        String batch = batchData.data['batch'];
        String gender = batchData.data['gender'];
        cr.document(rec[i]).delete();
        _decreaseBatchSCount(batch, gender);
      }

      List<String> rec1 = [];
      for (int i = 0; i < examNames.length; i++) {
        QuerySnapshot qs1 = await Firestore.instance
            .collection('${examNames[i]}')
            .where('${examNames[i]}_fName', isEqualTo: fName)
            .where('${examNames[i]}_lName', isEqualTo: lName)
            .getDocuments();
        for (int j = 0; j < qs1.documents.length; j++) {
          qs1.documents.forEach((element) {
            rec1.add(element.documentID);
          });
          for (int i = 0; i < rec1.length; i++) {
            Firestore.instance
                .collection('${examNames[i]}')
                .document('${rec1[i]}')
                .delete();
          }
        }
      }

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

  //check with master list------------------
  Future<bool> _checkWithMaterList(
      String fName, String lName, String batch) async {
    QuerySnapshot qs = await Firestore.instance
        .collection('students')
        .where('fName', isEqualTo: fName)
        .where('lName', isEqualTo: lName)
        .where('batch', isEqualTo: batch)
        .getDocuments();
    if (qs.documents.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //add single result---------------------
  Future<bool> addResult(
      String fName, String lName, String batch, String examName) async {
    bool exists = await _checkResult(fName, lName, examName);
    bool masterListCheck = await _checkWithMaterList(fName, lName, batch);
    if (exists) {
      return false;
    } else if (masterListCheck) {
      return null;
    } else {
      CollectionReference cr = Firestore.instance.collection('$examName');
      switch (batch) {
        case 'm1':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'comp': {
              'compInt': -1,
              'compTh': -1,
              'compPract': -1,
            },
            'maths': {
              'maths1Int': -1,
              'maths1Th': -1,
              'maths2Int': -1,
              'maths2Th': -1,
            },
            'stat': {
              'statInt': -1,
              'statTh': -1,
              'statPract': -1,
            },
            'subComb': 'smcs',
          });
          break;

        case 'm2':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'comp': {
              'compInt': -1,
              'compTh': -1,
              'compPract': -1,
            },
            'maths': {
              'maths1Int': -1,
              'maths1Th': -1,
              'maths2Int': -1,
              'maths2Th': -1,
            },
            'phy': {
              'phyInt': -1,
              'phyTh': -1,
              'phyPract': -1,
            },
            'subComb': 'pmcs',
          });
          break;

        case 'm3':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'phy': {
              'phyInt': -1,
              'phyTh': -1,
              'phyPract': -1,
            },
            'elec': {
              'elecInt': -1,
              'elecTh': -1,
              'elecPract': -1,
            },
            'comp': {
              'compInt': -1,
              'compTh': -1,
              'compPract': -1,
            },
            'subComb': 'pecs',
          });
          break;

        case 'm4':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'stat': {
              'statInt': -1,
              'statTh': -1,
              'statPract': -1,
            },
            'elec': {
              'elecInt': -1,
              'elecTh': -1,
              'elecPract': -1,
            },
            'comp': {
              'compInt': -1,
              'compTh': -1,
              'compPract': -1,
            },
            'subComb': 'secs',
          });
          break;

        case 'm5':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'phy': {
              'phyInt': -1,
              'phyTh': -1,
              'phyPract': -1,
            },
            'chem': {
              'chemInt': -1,
              'chemTh': -1,
              'chemPract': -1,
            },
            'comp': {
              'compInt': -1,
              'compTh': -1,
              'compPract': -1,
            },
            'subComb': 'pccs',
          });
          break;

        case 'm6':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'phy': {
              'phyInt': -1,
              'phyTh': -1,
              'phyPract': -1,
            },
            'maths': {
              'maths1Int': -1,
              'maths1Th': -1,
              'maths2Int': -1,
              'maths2Th': -1,
            },
            'elec': {
              'elecInt': -1,
              'elecTh': -1,
              'elecPract': -1,
            },
            'subComb': 'pme',
          });
          break;

        case 'm7':
          cr.add({
            '${examName}_fName': fName,
            '${examName}_lName': lName,
            'phy': {
              'phyInt': -1,
              'phyTh': -1,
              'phyPract': -1,
            },
            'chem': {
              'chemInt': -1,
              'chemTh': -1,
              'chemPract': -1,
            },
            'maths': {
              'maths1Int': -1,
              'maths1Th': -1,
              'maths2Int': -1,
              'maths2Th': -1,
            },
            'subComb': 'pcm',
          });
          break;
      }

      return true;
    }
  }

  // //delete single result-----------
  // Future<bool> deleteResult(String fName, String lName, String examName) async {
  //   bool exists = await _checkResult(fName, lName, examName);
  //   if (exists) {
  //     CollectionReference cr = Firestore.instance.collection('$examName');
  //     QuerySnapshot qs = await cr
  //         .where('${examName}_fName', isEqualTo: fName)
  //         .where('${examName}_lName', isEqualTo: lName)
  //         .getDocuments();
  //     List<String> rec = [];
  //     qs.documents.forEach((element) {
  //       rec.add(element.documentID);
  //     });
  //     for (int i = 0; i < rec.length; i++) {
  //       cr.document(rec[i]).delete();
  //     }

  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

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
      DocumentSnapshot ds = await Firestore.instance
          .collection('students')
          .document(documentID)
          .get();
      Firestore.instance
          .collection('students')
          .document(documentID)
          .updateData({
        'fName': fName,
        'lName': lName,
        'batch': batch,
        'gender': gender,
      });

      for (int i = 0; i < examNames.length; i++) {
        QuerySnapshot qs = await Firestore.instance
            .collection('${examNames[i]}')
            .where('${examNames[i]}_fName', isEqualTo: ds.data['fName'])
            .where('${examNames[i]}_lName', isEqualTo: ds.data['lName'])
            .getDocuments();
        for (int j = 0; j < qs.documents.length; j++) {
          String docID = qs.documents[j].documentID;
          if (!(ds.data['batch'] == batch)) {
            if (ds.data['batch'] == 'm1') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'stat': FieldValue.delete(),
                'maths': FieldValue.delete(),
                'comp': FieldValue.delete(),
              });
            }
            if (ds.data['batch'] == 'm2') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': FieldValue.delete(),
                'maths': FieldValue.delete(),
                'comp': FieldValue.delete(),
              });
            }
            if (ds.data['batch'] == 'm3') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': FieldValue.delete(),
                'elec': FieldValue.delete(),
                'comp': FieldValue.delete(),
              });
            }
            if (ds.data['batch'] == 'm4') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'stat': FieldValue.delete(),
                'elec': FieldValue.delete(),
                'comp': FieldValue.delete(),
              });
            }
            if (ds.data['batch'] == 'm5') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': FieldValue.delete(),
                'chem': FieldValue.delete(),
                'comp': FieldValue.delete(),
              });
            }
            if (ds.data['batch'] == 'm6') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': FieldValue.delete(),
                'maths': FieldValue.delete(),
                'elec': FieldValue.delete(),
              });
            }
            if (ds.data['batch'] == 'm7') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': FieldValue.delete(),
                'maths': FieldValue.delete(),
                'chem': FieldValue.delete(),
              });
            }

            //// adding new mark fields
            if (batch == 'm1') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'stat': {
                  'statInt': -1,
                  'statTh': -1,
                  'statPract': -1,
                },
                'maths': {
                  'maths1Int': -1,
                  'maths1Th': -1,
                  'maths2Int': -1,
                  'maths2Th': -1,
                },
                'comp': {
                  'compInt': -1,
                  'compTh': -1,
                  'compPract': -1,
                },
              });
            }
            if (batch == 'm2') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': {
                  'phyInt': -1,
                  'phyTh': -1,
                  'phyPract': -1,
                },
                'maths': {
                  'maths1Int': -1,
                  'maths1Th': -1,
                  'maths2Int': -1,
                  'maths2Th': -1,
                },
                'comp': {
                  'compInt': -1,
                  'compTh': -1,
                  'compPract': -1,
                },
              });
            }
            if (batch == 'm3') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': {
                  'phyInt': -1,
                  'phyTh': -1,
                  'phyPract': -1,
                },
                'elec': {
                  'elecInt': -1,
                  'elecTh': -1,
                  'elecPract': -1,
                },
                'comp': {
                  'compInt': -1,
                  'compTh': -1,
                  'compPract': -1,
                },
              });
            }
            if (batch == 'm4') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'stat': {
                  'statInt': -1,
                  'statTh': -1,
                  'statPract': -1,
                },
                'elec': {
                  'elecInt': -1,
                  'elecTh': -1,
                  'elecPract': -1,
                },
                'comp': {
                  'compInt': -1,
                  'compTh': -1,
                  'compPract': -1,
                },
              });
            }
            if (batch == 'm5') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': {
                  'phyInt': -1,
                  'phyTh': -1,
                  'phyPract': -1,
                },
                'chem': {
                  'chemInt': -1,
                  'chemTh': -1,
                  'chemPract': -1,
                },
                'comp': {
                  'compInt': -1,
                  'compTh': -1,
                  'compPract': -1,
                },
              });
            }
            if (batch == 'm6') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': {
                  'phyInt': -1,
                  'phyTh': -1,
                  'phyPract': -1,
                },
                'maths': {
                  'maths1Int': -1,
                  'maths1Th': -1,
                  'maths2Int': -1,
                  'maths2Th': -1,
                },
                'elec': {
                  'elecInt': -1,
                  'elecTh': -1,
                  'elecPract': -1,
                },
              });
            }
            if (batch == 'm7') {
              Firestore.instance
                  .collection('${examNames[i]}')
                  .document(docID)
                  .updateData({
                'phy': {
                  'phyInt': -1,
                  'phyTh': -1,
                  'phyPract': -1,
                },
                'maths': {
                  'maths1Int': -1,
                  'maths1Th': -1,
                  'maths2Int': -1,
                  'maths2Th': -1,
                },
                'chem': {
                  'chemInt': -1,
                  'chemTh': -1,
                  'chemPract': -1,
                },
              });
            }
          }
          Firestore.instance
              .collection('${examNames[i]}')
              .document(docID)
              .updateData({
            '${examNames[i]}_fName': fName,
            '${examNames[i]}_lName': lName,
            'subComb': batch == 'm1'
                ? 'smcs'
                : (batch == 'm2'
                    ? 'pmcs'
                    : (batch == 'm3'
                        ? 'pecs'
                        : (batch == 'm4'
                            ? 'secs'
                            : (batch == 'm5'
                                ? 'pccs'
                                : (batch == 'm6' ? 'pme' : 'pcm'))))),
          });
        }
      }
      return true;
    } catch (e) {
      return null;
    }
  }

  //get result record----------------
  Future getResultRecord(String fName, String lName, String examName) async {
    QuerySnapshot qs = await Firestore.instance
        .collection('$examName')
        .where(
          '${examName}_fName',
          isEqualTo: fName,
        )
        .where('${examName}_lName', isEqualTo: lName)
        .getDocuments();
    if (qs.documents.isNotEmpty) {
      return qs.documents[0];
    } else {
      return null;
    }
  }

  // update SMCS result-----------------------
  Future<bool> updateSmcsResult(
    String documentID,
    examName, {
    int statIntEdited,
    statThEdited,
    statPractEdited,
    maths1IntEdited,
    maths1ThEdited,
    maths2IntEdited,
    maths2ThEdited,
    compIntEdited,
    compThEdited,
    compPractEdited,
  }) async {
    try {
      Firestore.instance
          .collection('$examName')
          .document(documentID)
          .updateData({
        'stat': {
          'statInt': statIntEdited,
          'statTh': statThEdited,
          'statPract': statPractEdited,
        },
        'maths': {
          'maths1Int': maths1IntEdited,
          'maths1Th': maths1ThEdited,
          'maths2Int': maths2IntEdited,
          'maths2Th': maths2ThEdited,
        },
        'comp': {
          'compInt': compIntEdited,
          'compTh': compThEdited,
          'compPract': compPractEdited,
        },
      });
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // update PMCS result-----------------------
  Future<bool> updatePmcsResult(
    String documentID,
    examName, {
    int phyIntEdited,
    phyThEdited,
    phyPractEdited,
    maths1IntEdited,
    maths1ThEdited,
    maths2IntEdited,
    maths2ThEdited,
    compIntEdited,
    compThEdited,
    compPractEdited,
  }) async {
    try {
      Firestore.instance
          .collection('$examName')
          .document(documentID)
          .updateData({
        'phy': {
          'phyInt': phyIntEdited,
          'phyTh': phyThEdited,
          'phyPract': phyPractEdited,
        },
        'maths': {
          'maths1Int': maths1IntEdited,
          'maths1Th': maths1ThEdited,
          'maths2Int': maths2IntEdited,
          'maths2Th': maths2ThEdited,
        },
        'comp': {
          'compInt': compIntEdited,
          'compTh': compThEdited,
          'compPract': compPractEdited,
        },
      });
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //update PECS-----------
  Future<bool> updatePecsResult(
    String documentID,
    examName, {
    int phyIntEdited,
    phyThEdited,
    phyPractEdited,
    elecIntEdited,
    elecThEdited,
    elecPractEdited,
    compIntEdited,
    compThEdited,
    compPractEdited,
  }) async {
    try {
      Firestore.instance
          .collection('$examName')
          .document(documentID)
          .updateData({
        'phy': {
          'phyInt': phyIntEdited,
          'phyTh': phyThEdited,
          'phyPract': phyPractEdited,
        },
        'elec': {
          'elecInt': elecIntEdited,
          'elecTh': elecThEdited,
          'elecPract': elecPractEdited,
        },
        'comp': {
          'compInt': compIntEdited,
          'compTh': compThEdited,
          'compPract': compPractEdited,
        },
      });
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //update SECS-----------
  Future<bool> updateSecsResult(
    String documentID,
    examName, {
    int statIntEdited,
    statThEdited,
    statPractEdited,
    elecIntEdited,
    elecThEdited,
    elecPractEdited,
    compIntEdited,
    compThEdited,
    compPractEdited,
  }) async {
    try {
      Firestore.instance
          .collection('$examName')
          .document(documentID)
          .updateData({
        'stat': {
          'statInt': statIntEdited,
          'statTh': statThEdited,
          'statPract': statPractEdited,
        },
        'elec': {
          'elecInt': elecIntEdited,
          'elecTh': elecThEdited,
          'elecPract': elecPractEdited,
        },
        'comp': {
          'compInt': compIntEdited,
          'compTh': compThEdited,
          'compPract': compPractEdited,
        },
      });
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //update PCCS-----------
  Future<bool> updatePccsResult(
    String documentID,
    examName, {
    int phyIntEdited,
    phyThEdited,
    phyPractEdited,
    chemIntEdited,
    chemThEdited,
    chemPractEdited,
    compIntEdited,
    compThEdited,
    compPractEdited,
  }) async {
    try {
      Firestore.instance
          .collection('$examName')
          .document(documentID)
          .updateData({
        'phy': {
          'phyInt': phyIntEdited,
          'phyTh': phyThEdited,
          'phyPract': phyPractEdited,
        },
        'chem': {
          'chemInt': chemIntEdited,
          'chemTh': chemThEdited,
          'chemPract': chemPractEdited,
        },
        'comp': {
          'compInt': compIntEdited,
          'compTh': compThEdited,
          'compPract': compPractEdited,
        },
      });
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // update PME result-----------------------
  Future<bool> updatePmeResult(
    String documentID,
    examName, {
    int phyIntEdited,
    phyThEdited,
    phyPractEdited,
    maths1IntEdited,
    maths1ThEdited,
    maths2IntEdited,
    maths2ThEdited,
    elecIntEdited,
    elecThEdited,
    elecPractEdited,
  }) async {
    try {
      Firestore.instance
          .collection('$examName')
          .document(documentID)
          .updateData({
        'phy': {
          'phyInt': phyIntEdited,
          'phyTh': phyThEdited,
          'phyPract': phyPractEdited,
        },
        'maths': {
          'maths1Int': maths1IntEdited,
          'maths1Th': maths1ThEdited,
          'maths2Int': maths2IntEdited,
          'maths2Th': maths2ThEdited,
        },
        'elec': {
          'elecInt': elecIntEdited,
          'elecTh': elecThEdited,
          'elecPract': elecPractEdited,
        },
      });
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // update PCM result-----------------------
  Future<bool> updatePcmResult(
    String documentID,
    examName, {
    int phyIntEdited,
    phyThEdited,
    phyPractEdited,
    maths1IntEdited,
    maths1ThEdited,
    maths2IntEdited,
    maths2ThEdited,
    chemIntEdited,
    chemThEdited,
    chemPractEdited,
  }) async {
    try {
      Firestore.instance
          .collection('$examName')
          .document(documentID)
          .updateData({
        'phy': {
          'phyInt': phyIntEdited,
          'phyTh': phyThEdited,
          'phyPract': phyPractEdited,
        },
        'maths': {
          'maths1Int': maths1IntEdited,
          'maths1Th': maths1ThEdited,
          'maths2Int': maths2IntEdited,
          'maths2Th': maths2ThEdited,
        },
        'chem': {
          'chemInt': chemIntEdited,
          'chemTh': chemThEdited,
          'chemPract': chemPractEdited,
        },
      });
      return true;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //----------get quote---------
  Future getQuoteInfo() async {
    try {
      DocumentSnapshot ds =
          await Firestore.instance.document('/quotes/quote').get();
      return ds;
    } catch (e) {
      return null;
    }
  }

  ///update quote------------
  Future<bool> updateQuote(String quote, String author) async {
    try {
      DocumentReference dr = Firestore.instance.document('/quotes/quote');
      await dr.updateData({
        'quote': quote,
        'author': author,
        'updated': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
