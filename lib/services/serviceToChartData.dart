import '../class/marksDataObj.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

Random rnd = new Random();
int minTheory = 15;
int maxTheory = 80;
int minInt = 5;
int maxInt = 20;
int minMathsInt = 10;
int maxMathsInt = 15;
int minMathsTheory = 10;
int maxMathsTheory = 60;
int minPract = 20;
int maxPract = 50;

class ServiceToChartData {
  List<MarksDataObj> marksList = [];
  List<MarksDataObj> giveMarks(DocumentSnapshot data) {
    if (data.data.containsKey('stat')) {
      int statInt = data.data['stat']['statInt'] == null
          ? minInt + rnd.nextInt(maxInt - minInt)
          : data.data['stat']['statInt'];
      int statTh = data.data['stat']['statTh'] == null
          ? minTheory + rnd.nextInt(maxTheory - minTheory)
          : data.data['stat']['statTh'];
      int statPract = data.data['stat']['statPract'] == null
          ? minPract + rnd.nextInt(maxPract - minPract)
          : data.data['stat']['statPract'];
      marksList.add(MarksDataObj(
        'Stat',
        statInt,
        statTh,
        statPract,
      ));
    }
    if (data.data.containsKey('phy')) {
      int phyInt = data.data['phy']['phyInt'] == null
          ? minInt + rnd.nextInt(maxInt - minInt)
          : data.data['phy']['phyInt'];
      int phyTh = data.data['phy']['phyTh'] == null
          ? minTheory + rnd.nextInt(maxTheory - minTheory)
          : data.data['phy']['phyTh'];
      int phyPract = data.data['phy']['phyPract'] == null
          ? minPract + rnd.nextInt(maxPract - minPract)
          : data.data['phy']['phyPract'];
      marksList.add(MarksDataObj(
        'Phy',
        phyInt,
        phyTh,
        phyPract,
      ));
    }
    if (data.data.containsKey('elec')) {
      int elecInt = data.data['elec']['elecInt'] == null
          ? minInt + rnd.nextInt(maxInt - minInt)
          : data.data['elec']['elecInt'];
      int elecTh = data.data['elec']['elecTh'] == null
          ? minTheory + rnd.nextInt(maxTheory - minTheory)
          : data.data['elec']['elecTh'];
      int elecPract = data.data['elec']['elecPract'] == null
          ? minPract + rnd.nextInt(maxPract - minPract)
          : data.data['elec']['elecPract'];
      marksList.add(MarksDataObj(
        'Elec',
        elecInt,
        elecTh,
        elecPract,
      ));
    }
    if (data.data.containsKey('chem')) {
      int chemInt = data.data['chem']['chemInt'] == null
          ? minInt + rnd.nextInt(maxInt - minInt)
          : data.data['chem']['chemInt'];
      int chemTh = data.data['chem']['chemTh'] == null
          ? minTheory + rnd.nextInt(maxTheory - minTheory)
          : data.data['chem']['chemTh'];
      int chemPract = data.data['chem']['chemPract'] == null
          ? minPract + rnd.nextInt(maxPract - minPract)
          : data.data['chem']['chemPract'];
      marksList.add(MarksDataObj(
        'Chem',
        chemInt,
        chemTh,
        chemPract,
      ));
    }
    if (data.data.containsKey('comp')) {
      int compInt = data.data['comp']['compInt'] == null
          ? minInt + rnd.nextInt(maxInt - minInt)
          : data.data['comp']['compInt'];
      int compTh = data.data['comp']['compTh'] == null
          ? minTheory + rnd.nextInt(maxTheory - minTheory)
          : data.data['comp']['compTh'];
      int compPract = data.data['comp']['compPract'] == null
          ? minPract + rnd.nextInt(maxPract - minPract)
          : data.data['comp']['compPract'];
      marksList.add(MarksDataObj(
        'Comp',
        compInt,
        compTh,
        compPract,
      ));
    }
    if (data.data.containsKey('maths')) {
      int maths1Int = data.data['maths']['maths1Int'] == null
          ? minMathsInt + rnd.nextInt(maxMathsInt - minMathsInt)
          : data.data['maths']['maths1Int'];
      int maths1Th = data.data['maths']['maths1Th'] == null
          ? minMathsTheory + rnd.nextInt(maxMathsTheory - minMathsTheory)
          : data.data['maths']['maths1Th'];
      marksList.add(MarksDataObj(
        'Maths1',
        maths1Int,
        maths1Th,
        null,
      ));
    }
    if (data.data.containsKey('maths')) {
      int maths2Int = data.data['maths']['maths2Int'] == null
          ? minMathsInt + rnd.nextInt(maxMathsInt - minMathsInt)
          : data.data['maths']['maths2Int'];
      int maths2Th = data.data['maths']['maths2Th'] == null
          ? minMathsTheory + rnd.nextInt(maxMathsTheory - minMathsTheory)
          : data.data['maths']['maths2Th'];
      marksList.add(MarksDataObj(
        'Maths2',
        maths2Int,
        maths2Th,
        null,
      ));
    }

    return marksList;
  }
}
