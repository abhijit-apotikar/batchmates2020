import 'package:cloud_firestore/cloud_firestore.dart';
class ArgumentDetailsOther {
  final String fname, lname;
  final DocumentSnapshot data;
  final int index;
  ArgumentDetailsOther(this.fname, this.lname, this.index,this.data);
}