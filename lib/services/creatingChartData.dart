import '../class/marksDataModel.dart';
import '../class/marksDataObj.dart';

class CreatingChartData {
  final int idx;
  CreatingChartData(this.idx);
  List<MarksData> returnChartData(Marks marks) {
    List<MarksData> chartData1;
    if (idx == 1) {
      chartData1 = [
        MarksData('Stat', marks.stat, marks.statInt, marks.statPract),
        MarksData('Comp', marks.comp, marks.compInt, marks.compPract),
        MarksData('Maths1', marks.maths1, marks.maths1Int, null),
        MarksData('Maths2', marks.maths2, marks.maths2Int, null),
      ];
    } else if (idx == 2) {
      chartData1 = [
        MarksData('Phy', marks.physics, marks.phyInt, marks.phyPract),
        MarksData('Comp', marks.comp, marks.compInt, marks.compPract),
        MarksData('Maths1', marks.maths1, marks.maths1Int, null),
        MarksData('Maths2', marks.maths2, marks.maths2Int, null),
      ];
    } else if (idx == 3) {
      chartData1 = [
        MarksData('Phy', marks.physics, marks.phyInt, marks.phyPract),
        MarksData('Elec', marks.elec, marks.elecInt, marks.elecPract),
        MarksData('Comp', marks.comp, marks.compInt, marks.compPract),
      ];
    } else if (idx == 4) {
      chartData1 = [
        MarksData('Stat', marks.stat, marks.statInt, marks.statPract),
        MarksData('Elec', marks.elec, marks.elecInt, marks.elecPract),
        MarksData('Comp', marks.comp, marks.compInt, marks.compPract),
      ];
    } else if (idx == 5) {
      chartData1 = [
        MarksData('Phy', marks.physics, marks.phyInt, marks.phyPract),
        MarksData('Chem', marks.chem, marks.chemInt, marks.chemPract),
        MarksData('Comp', marks.comp, marks.compInt, marks.compPract),
      ];
    } else if (idx == 6) {
      chartData1 = [
        MarksData('Phy', marks.physics, marks.phyInt, marks.phyPract),
        MarksData('Maths1', marks.maths1, marks.maths1Int, null),
        MarksData('Maths2', marks.maths2, marks.maths2Int, null),
        MarksData('Elec', marks.elec, marks.elecInt, marks.elecPract),
      ];
    } else if (idx == 7) {
      chartData1 = [
        MarksData('Phy', marks.physics, marks.phyInt, marks.phyPract),
        MarksData('Chem', marks.chem, marks.chemInt, marks.chemPract),
        MarksData('Maths1', marks.maths1, marks.maths1Int, null),
        MarksData('Maths2', marks.maths2, marks.maths2Int, null),
      ];
    }

    return chartData1;
  }
}
