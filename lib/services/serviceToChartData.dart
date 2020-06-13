import '../class/marksDataObj.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceToChartData {
  List<MarksDataObj> marksList = [];
  List<MarksDataObj> giveMarks(DocumentSnapshot data) {
    if (data.data.containsKey('stat')) {
      marksList.add(MarksDataObj('Stat', data.data['stat']['statInt'],
          data.data['stat']['statTh'], data.data['stat']['statPract']));
    }
    if (data.data.containsKey('comp')) {
      marksList.add(MarksDataObj('Comp', data.data['comp']['compInt'],
          data.data['comp']['comp'], data.data['comp']['comp']));
    }
    if (data.data.containsKey('maths1')) {
      marksList.add(MarksDataObj('Maths1', data.data['maths1']['maths1Int'],
          data.data['maths1']['maths1'], 0));
    }
    if (data.data.containsKey('maths2')) {
      marksList.add(MarksDataObj('maths2', data.data['maths2']['maths2Int'],
          data.data['maths2']['maths2'], 0));
    }
    return marksList;
  }
}
