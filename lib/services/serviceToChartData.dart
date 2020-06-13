import '../class/marksDataObj.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceToChartData {
  List<MarksDataObj> marksList = [];
  List<MarksDataObj> giveMarks(DocumentSnapshot data) {
    if (data.data.containsKey('stat')) {
      marksList.add(MarksDataObj(
          'Stat',
          data.data['stat']['statInt'],
          data.data['stat']['statTh'],
          data.data['stat']['statPract'],
          data.data['stat']['statInt'] + data['stat']['statTh']));
    }
    if (data.data.containsKey('comp')) {
      marksList.add(MarksDataObj(
          'Comp',
          data.data['comp']['compInt'],
          data.data['comp']['compTh'],
          data.data['comp']['compPract'],
          data.data['comp']['compInt'] + data['comp']['compTh']));
    }
    if (data.data.containsKey('maths')) {
      marksList.add(MarksDataObj(
          'Maths1',
          data.data['maths']['maths1Int'],
          data.data['maths']['maths1Th'],
          0,
          data.data['maths']['maths1Int'] + data['maths']['maths1Th']));
    }
    if (data.data.containsKey('maths')) {
      marksList.add(MarksDataObj(
          'Maths2',
          data.data['maths']['maths2Int'],
          data.data['maths']['maths2Th'],
          0,
          data.data['maths']['maths2Int'] + data['maths']['maths2Th']));
    }
    return marksList;
  }
}
