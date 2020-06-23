import 'package:flutter/material.dart';

import '../shared.dart/constants.dart';

import '../services/firestoreDatabaseService.dart';

import '../widgets/successAlertDialog.dart';
import '../widgets/failureAlertDialog.dart';
import '../widgets/loadingWidget.dart';

class DeleteStudent extends StatefulWidget {
  @override
  _DeleteStudentState createState() => _DeleteStudentState();
}

class _DeleteStudentState extends State<DeleteStudent> {
  final _formKey3 = GlobalKey<FormState>();
  bool loading = false;

  final _fNameCtrl = new TextEditingController();
  final _lNameCtrl = new TextEditingController();

  FirestoreDatabaseService fds = new FirestoreDatabaseService();

  String error = '';

  String fName = '';
  String lName = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey3,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    style: myTextFormFieldTextStyle,
                    controller: _fNameCtrl,
                    decoration: textFormFieldDecoration.copyWith(
                        hintText: 'First name'),
                    validator: (value) =>
                        value.isEmpty ? 'first name can\'t be empty' : null,
                    onChanged: (val) {
                      setState(() {
                        fName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: myTextFormFieldTextStyle,
                    controller: _lNameCtrl,
                    decoration:
                        textFormFieldDecoration.copyWith(hintText: 'Last name'),
                    validator: (value) =>
                        value.isEmpty ? 'last name can\'t be empty' : null,
                    onChanged: (val) {
                      setState(() {
                        lName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                          'Delete Student',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                        onPressed: () async {
                          if (_formKey3.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await fds.deleteStudent(
                              fName,
                              lName,
                            );
                            if (result) {
                              setState(() {
                                loading = false;
                                error = 'Student deleted Successfully';
                                showSuccessAlertDialog(context, error);
                                _fNameCtrl.clear();
                                _lNameCtrl.clear();
                              });
                            } else {
                              setState(() {
                                loading = false;
                                error = 'sorry, specified student do not exist';
                                showFailureAlertDialog(context, error);
                                _fNameCtrl.clear();
                                _lNameCtrl.clear();
                              });
                            }
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
