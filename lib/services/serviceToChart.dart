class ServiceToChart {
  final String fname;
  final String lname;
  //final int idx;
  ServiceToChart(this.fname, this.lname);
  // var md1 = marksData;
  // var md2 = marksData2;

  List returnExactRecord(List md1) {
    var exactMarksData1 = md1
        .where((result) => result['fname'] == fname && result['lname'] == lname)
        .toList();

    return exactMarksData1;
  }
}
