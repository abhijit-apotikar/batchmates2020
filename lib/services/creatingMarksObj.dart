import '../class/marksDataModel.dart';

class CreatingMarksObj {
  final int idx;

  //List exactInfo;
  CreatingMarksObj(this.idx);

  Marks returnMarksObj(List l) {
    Marks marks1;
    if (idx == 1) {
      var stat = l[0]['stat'];
      var statInt = l[0]['statInt'];
      var comp = l[0]['comp'];
      var compInt = l[0]['compInt'];
      var maths1 = l[0]['maths1'];
      var maths1Int = l[0]['maths1Int'];
      var maths2 = l[0]['maths2'];
      var maths2Int = l[0]['maths2Int'];
      var statPract = l[0]['statPract'];
      var compPract = l[0]['compPract'];

      marks1 = Marks(
          null,
          null,
          stat,
          statInt,
          comp,
          compInt,
          null,
          null,
          null,
          null,
          maths1,
          maths1Int,
          maths2,
          maths2Int,
          null,
          statPract,
          compPract,
          null,
          null);
    } else if (idx == 2) {
      var phy = l[0]['phy'];
      var phyInt = l[0]['phyInt'];
      var comp = l[0]['comp'];
      var compInt = l[0]['compInt'];
      var maths1 = l[0]['maths1'];
      var maths1Int = l[0]['maths1Int'];
      var maths2 = l[0]['maths2'];
      var maths2Int = l[0]['maths2Int'];
      var phyPract = l[0]['phyPract'];
      var compPract = l[0]['compPract'];

      marks1 = Marks(
          phy,
          phyInt,
          null,
          null,
          comp,
          compInt,
          null,
          null,
          null,
          null,
          maths1,
          maths1Int,
          maths2,
          maths2Int,
          phyPract,
          null,
          compPract,
          null,
          null);
    } else if (idx == 3) {
      var phy = l[0]['phy'];
      var phyInt = l[0]['phyInt'];
      var elec = l[0]['elec'];
      var elecInt = l[0]['elecInt'];
      var comp = l[0]['comp'];
      var compInt = l[0]['compInt'];
      var phyPract = l[0]['phyPract'];
      var elecPract = l[0]['elecPract'];
      var compPract = l[0]['compPract'];

      marks1 = Marks(
          phy,
          phyInt,
          null,
          null,
          comp,
          compInt,
          elec,
          elecInt,
          null,
          null,
          null,
          null,
          null,
          null,
          phyPract,
          null,
          compPract,
          elecPract,
          null);
    } else if (idx == 4) {
      var stat = l[0]['stat'];
      var statInt = l[0]['statInt'];
      var elec = l[0]['elec'];
      var elecInt = l[0]['elecInt'];
      var comp = l[0]['comp'];
      var compInt = l[0]['compInt'];
      var statPract = l[0]['statPract'];
      var elecPract = l[0]['elecPract'];
      var compPract = l[0]['compPract'];
      marks1 = Marks(
          null,
          null,
          stat,
          statInt,
          comp,
          compInt,
          elec,
          elecInt,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          statPract,
          compPract,
          elecPract,
          null);
    } else if (idx == 5) {
      var phy = l[0]['phy'];
      var phyInt = l[0]['phyInt'];
      var chem = l[0]['chem'];
      var chemInt = l[0]['chemInt'];
      var comp = l[0]['comp'];
      var compInt = l[0]['compInt'];
      var phyPract = l[0]['phyPract'];
      var chemPract = l[0]['chemPract'];
      var compPract = l[0]['compPract'];

      marks1 = Marks(
          phy,
          phyInt,
          null,
          null,
          comp,
          compInt,
          null,
          null,
          chem,
          chemInt,
          null,
          null,
          null,
          null,
          phyPract,
          null,
          compPract,
          null,
          chemPract);
    } else if (idx == 6) {
      var phy = l[0]['phy'];
      var phyInt = l[0]['phyInt'];
      var maths1 = l[0]['maths1'];
      var maths1Int = l[0]['maths1Int'];
      var maths2 = l[0]['maths2'];
      var maths2Int = l[0]['maths2Int'];
      var elec = l[0]['elec'];
      var elecInt = l[0]['elecInt'];
      var phyPract = l[0]['phyPract'];
      var elecPract = l[0]['elecPract'];

      marks1 = Marks(
          phy,
          phyInt,
          null,
          null,
          null,
          null,
          elec,
          elecInt,
          null,
          null,
          maths1,
          maths1Int,
          maths2,
          maths2Int,
          phyPract,
          null,
          null,
          elecPract,
          null);
    } else if (idx == 7) {
      var phy = l[0]['phy'];
      var phyInt = l[0]['phyInt'];
      var chem = l[0]['chem'];
      var chemInt = l[0]['chemInt'];
      var maths1 = l[0]['maths1'];
      var maths1Int = l[0]['maths1Int'];
      var maths2 = l[0]['maths2'];
      var maths2Int = l[0]['maths2Int'];
      var phyPract = l[0]['phyPract'];
      var chemPract = l[0]['chemPract'];
      marks1 = Marks(
          phy,
          phyInt,
          null,
          null,
          null,
          null,
          null,
          null,
          chem,
          chemInt,
          maths1,
          maths1Int,
          maths2,
          maths2Int,
          phyPract,
          null,
          null,
          null,
          chemPract);
    }

    return marks1;
  }
}
