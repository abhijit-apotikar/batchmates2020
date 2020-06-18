import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';
import '../widgets/insertStudent.dart';

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
                          ? Container()
                          : (isInsertingBulk ? Container() : Container())),
                ],
              ),
            )
          : (isUpdating
              ? Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Update: '),
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
                              if (newValue == 'Student') {}
                            });
                          },
                          items: <String>[
                            'Student',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
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
                              insertDropdownValue = newValue;
                              if (newValue == 'Student') {
                              } else if (newValue == 'Single') {
                              } else if (newValue == 'Bulk') {
                              } else if (newValue == 'Special') {}
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
                  ],
                )),
    );
  }
}
