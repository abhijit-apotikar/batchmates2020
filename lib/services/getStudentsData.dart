import 'package:cloud_firestore/cloud_firestore.dart';

class GetStudentsData {
  
  List<Map<String, dynamic>> getStudentsData() {
    List<Map<String, dynamic>> studentsData = [];
    var document = Firestore.instance.document('studentsExpress/onlyStudents');

    document.get().then((value) {
      // print(value.data['1']);
      // print(value.data['2']);
      for (int i = 0; i < value.data.length; i++) {
        studentsData.add(value.data['${i + 1}']);
      }
      for (int i = 0; i < studentsData.length; i++) {
        print('Working');
        print(studentsData[i]);
      }
    });
    
    return studentsData;
  }
}
