import 'package:flutter/material.dart';
import '../services/firestoreDatabaseService.dart';

import '../shared.dart/constants.dart';
import '../widgets/successAlertDialog.dart';
import '../widgets/failureAlertDialog.dart';
import '../widgets/loadingWidget.dart';

class UpdateStudent extends StatefulWidget {
  @override
  _UpdateStudentState createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  bool loading = false;
  FirestoreDatabaseService fds = new FirestoreDatabaseService();
  var dr;
  bool isRecordAvailable = false;

  String error = '';

  final fNameCtrl = new TextEditingController();
  final lNameCtrl = new TextEditingController();
  // final fNameCtrlEdited = new TextEditingController();
  // final lNameCtrlEdited = new TextEditingController();
  // final batchCtrlEdited = new TextEditingController();
  // final genderCtrlEdited = new TextEditingController();
  String fName = '';
  String lName = '';
  String fNameEdited = '';
  String lNameEdited = '';
  String batchEdited = '';
  String genderEdited = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget()
        : isRecordAvailable
            ? Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Form(
                        key: _formKey6,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: myTextFormFieldTextStyle,
                              decoration: textFormFieldDecoration.copyWith(
                                labelText: 'First Name',
                              ),
                              // controller: fNameCtrlEdited,
                              initialValue: dr.data['fName'],
                              validator: (value) => value.isEmpty
                                  ? 'first name can\'t be empty'
                                  : null,
                              onChanged: (value) {
                                fNameEdited = value;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: myTextFormFieldTextStyle,
                              decoration: textFormFieldDecoration.copyWith(
                                labelText: 'Last Name',
                              ),
                              // controller: lNameCtrlEdited,
                              initialValue: dr.data['lName'],
                              validator: (value) => value.isEmpty
                                  ? 'last name can\'t be empty'
                                  : null,
                              onChanged: (value) {
                                lNameEdited = value;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: myTextFormFieldTextStyle,
                              decoration: textFormFieldDecoration.copyWith(
                                labelText: 'Batch',
                              ),
                              // controller: batchCtrlEdited,
                              initialValue: dr.data['batch'],
                              validator: (value) => value.isEmpty
                                  ? 'last name can\'t be empty'
                                  : null,
                              onChanged: (value) {
                                batchEdited = value;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: myTextFormFieldTextStyle,
                              decoration: textFormFieldDecoration.copyWith(
                                labelText: 'Gender',
                              ),
                              // controller: genderCtrlEdited,
                              initialValue: dr.data['gender'],
                              validator: (value) => value.isEmpty
                                  ? 'last name can\'t be empty'
                                  : null,
                              onChanged: (value) {
                                genderEdited = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      child: Text(
                        'update',
                        style: TextStyle(fontFamily: 'Nunito'),
                      ),
                      onPressed: () async {
                        if (_formKey6.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await fds.updateStudentRecord(
                            dr.documentID,
                            fNameEdited,
                            lNameEdited,
                            batchEdited,
                            genderEdited,
                          );
                          if (result) {
                            setState(() {
                              loading = false;
                              error = 'Student record updated successfully';
                              showSuccessAlertDialog(context, error);
                              isRecordAvailable = false;
                            });
                          } else {
                            loading = false;
                            error = 'Student record updation failed';
                            showFailureAlertDialog(context, error);
                            isRecordAvailable = false;
                          }
                        }
                      },
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey5,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: myTextFormFieldTextStyle,
                            decoration: textFormFieldDecoration.copyWith(
                                hintText: 'First Name'),
                            validator: (value) => value.isEmpty
                                ? 'first name can not be empty'
                                : null,
                            onChanged: (value) {
                              setState(() {
                                fName = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: myTextFormFieldTextStyle,
                            decoration: textFormFieldDecoration.copyWith(
                                hintText: 'Last Name'),
                            validator: (value) => value.isEmpty
                                ? 'last name can not be empty'
                                : null,
                            onChanged: (value) {
                              setState(() {
                                lName = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            child: Text(
                              'Get Record',
                              style: TextStyle(fontFamily: 'Nunito'),
                            ),
                            onPressed: () async {
                              if (_formKey5.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await fds.getStudentRecord(fName, lName);
                                if (!(result == null)) {
                                  setState(() {
                                    loading = false;
                                    dr = result;
                                    fNameEdited = dr.data['fName'];
                                    lNameEdited = dr.data['lName'];
                                    batchEdited = dr.data['batch'];
                                    genderEdited = dr.data['gender'];
                                    isRecordAvailable = true;
                                  });
                                } else {
                                  loading = false;
                                  error = 'Requested record not found';
                                  showFailureAlertDialog(context, error);
                                  fNameCtrl.clear();
                                  lNameCtrl.clear();
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
  }
}
