import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';

import '../widgets/insertStudent.dart';
import '../widgets/deleteStudent.dart';
import '../widgets/updateStudent.dart';
import '../widgets/updateResult.dart';
import '../widgets/updateQuote.dart';

class EditRecordWidget extends StatefulWidget {
  @override
  _EditRecordWidgetState createState() => _EditRecordWidgetState();
}

class _EditRecordWidgetState extends State<EditRecordWidget> {
  String dropdownValue = 'Insert';
  bool isInserting = true;
  bool isUpdating = false;
  bool isDeleting = false;

  String updateDropdownValue = 'Student';
  bool isUpdatingStudent = true;
  bool isUpdatingResult = false;
  bool isUpdatingQuote = false;

  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  height: size.height * 1.0,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          localColorCode.editGradient1,
                          localColorCode.editGradient2,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        // begin: const FractionalOffset(0.0, 0.0),
                        // end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Insert Student',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InsertStudent(),
                    ],
                  ),
                ),
              )
            : (isUpdating
                ? SingleChildScrollView(
                    child: Container(
                      height: size.height * 1.0,
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              localColorCode.editGradient1,
                              localColorCode.editGradient2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // begin: const FractionalOffset(0.0, 0.0),
                            // end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
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
                                      isUpdatingResult = false;
                                      isUpdatingQuote = false;
                                      isUpdatingStudent = true;
                                    } else if (newValue == 'Result') {
                                      isUpdatingStudent = false;
                                      isUpdatingQuote = false;
                                      isUpdatingResult = true;
                                    } else if (newValue == 'Quote') {
                                      isUpdatingStudent = false;
                                      isUpdatingResult = false;
                                      isUpdatingQuote = true;
                                    }
                                  });
                                },
                                items: <String>[
                                  'Student',
                                  'Result',
                                  'Quote'
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
                              : (isUpdatingResult
                                  ? UpdateResult()
                                  : UpdateQuote())
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      height: size.height * 1.0,
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              localColorCode.editGradient1,
                              localColorCode.editGradient2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // begin: const FractionalOffset(0.0, 0.0),
                            // end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Delete Student',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                          DeleteStudent(),
                        ],
                      ),
                    ),
                  )));
  }
}
