import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';
import '../widgets/insertStudent.dart';
import '../widgets/singleResult.dart';
import '../widgets/deleteStudent.dart';
import '../widgets/deleteResult.dart';
import '../widgets/updateStudent.dart';

import '../services/authService.dart';

class EditRecordWidget extends StatefulWidget {
  @override
  _EditRecordWidgetState createState() => _EditRecordWidgetState();
}

class _EditRecordWidgetState extends State<EditRecordWidget> {
  String dropdownValue = 'Insert';
  bool isInserting = true;
  bool isUpdating = false;
  bool isDeleting = false;

  String insertDropdownValue = 'Student';
  bool isInsertingStudent = true;
  bool isInsertingSingle = false;
  bool isInsertingBulk = false;
  bool isInsertingSpecial = false;

  String deleteDropdownValue = 'Student';
  bool isDeletingStudent = true;
  bool isDeletingSingle = false;
  bool isDeletingBulk = false;
  bool isDeletingSpecial = false;

  String updateDropdownValue = 'Student';
  bool isUpdatingStudent = true;
  bool isUpdatingSingle = false;
  bool isUpdatingQuote = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text(
          'Edit Records',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: localColorCode.ccAppBarForegroundColor,
          ),
        ),
        iconTheme: new IconThemeData(
          color: localColorCode.ccAppBarForegroundColor,
          size: 28,
        ),
        actions: <Widget>[
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                if (newValue == 'Insert') {
                  isUpdating = false;
                  isDeleting = false;
                  isInserting = true;
                } else if (newValue == 'Update') {
                  isInserting = false;
                  isDeleting = false;
                  isUpdating = true;
                } else if (newValue == 'Delete') {
                  isInserting = false;
                  isUpdating = false;
                  isDeleting = true;
                }
              });
            },
            items: <String>[
              'Insert',
              'Update',
              'Delete',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: isInserting
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Insert: '),
                      DropdownButton<String>(
                        value: insertDropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            insertDropdownValue = newValue;
                            if (newValue == 'Student') {
                              isInsertingSingle = false;
                              isInsertingBulk = false;
                              isInsertingSpecial = false;
                              isInsertingStudent = true;
                            } else if (newValue == 'Single') {
                              isInsertingStudent = false;
                              isInsertingBulk = false;
                              isInsertingSpecial = false;
                              isInsertingSingle = true;
                            } else if (newValue == 'Bulk') {
                              isInsertingStudent = false;
                              isInsertingSingle = false;
                              isInsertingSpecial = false;
                              isInsertingBulk = true;
                            } else if (newValue == 'Special') {
                              isInsertingStudent = false;
                              isInsertingSingle = false;
                              isInsertingBulk = false;
                              isInsertingSpecial = true;
                            }
                          });
                        },
                        items: <String>[
                          'Student',
                          'Single',
                          'Bulk',
                          'Special',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  isInsertingStudent
                      ? InsertStudent()
                      : (isInsertingSingle
                          ? SingleResult()
                          : (isInsertingBulk ? Container() : Container())),
                ],
              ),
            )
          : (isUpdating
              ? Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Update: '),
                            DropdownButton<String>(
                              value: updateDropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent,
                              ),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  updateDropdownValue = newValue;
                                  if (newValue == 'Student') {
                                    isUpdatingSingle = false;
                                    isUpdatingQuote = false;
                                    isUpdatingStudent = true;
                                  } else if (newValue == 'Result') {
                                    isUpdatingStudent = false;
                                    isUpdatingQuote = false;
                                    isUpdatingSingle = true;
                                  } else if (newValue == 'Quote') {
                                    isUpdatingStudent = false;
                                    isUpdatingSingle = false;
                                    isUpdatingQuote = true;
                                  }
                                });
                              },
                              items: <String>[
                                'Student',
                                'Result',
                                'Quote',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        isUpdatingStudent
                            ? UpdateStudent()
                            : (isUpdatingSingle ? Container() : Container())
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Delete: '),
                          DropdownButton<String>(
                            value: insertDropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                deleteDropdownValue = newValue;
                                if (newValue == 'Student') {
                                  isDeletingSingle = false;
                                  isDeletingBulk = false;
                                  isDeletingSpecial = false;
                                  isDeletingStudent = true;
                                } else if (newValue == 'Single') {
                                  isDeletingStudent = false;
                                  isDeletingBulk = false;
                                  isDeletingSpecial = false;
                                  isDeletingSingle = true;
                                } else if (newValue == 'Bulk') {
                                  isDeletingStudent = false;
                                  isDeletingSingle = false;
                                  isDeletingSpecial = false;
                                  isDeletingBulk = true;
                                } else if (newValue == 'Special') {
                                  isDeletingStudent = false;
                                  isDeletingSingle = false;
                                  isDeletingBulk = false;
                                  isDeletingSpecial = true;
                                }
                              });
                            },
                            items: <String>[
                              'Student',
                              'Single',
                              'Bulk',
                              'Special',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      isDeletingStudent
                          ? DeleteStudent()
                          : (isDeletingSingle
                              ? DeleteResult()
                              : (isDeletingBulk ? Container() : Container())),
                    ],
                  ),
                )),
    );
  }
}
