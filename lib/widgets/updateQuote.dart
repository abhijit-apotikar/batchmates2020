import 'package:flutter/material.dart';

import '../shared.dart/constants.dart';
import '../services/firestoreDatabaseService.dart';
import '../widgets/successAlertDialog.dart';
import '../widgets/failureAlertDialog.dart';
import '../widgets/loadingWidget.dart';

class UpdateQuote extends StatefulWidget {
  @override
  _UpdateQuoteState createState() => _UpdateQuoteState();
}

class _UpdateQuoteState extends State<UpdateQuote> {
  final _formKey12 = GlobalKey<FormState>();
  bool loading = false;
  FirestoreDatabaseService fds = new FirestoreDatabaseService();
  var dr;
  bool isRecordAvailable = false;

  String error = '';

  final quoteCtrl = new TextEditingController();
  final authorCtrl = new TextEditingController();

  String quote = '';
  String author = '';
  String quoteEdited = '';
  String authorEdited = '';

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
                        key: _formKey12,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: textFormFieldDecoration.copyWith(
                                labelText: 'Quote',
                              ),
                              // controller: fNameCtrlEdited,
                              initialValue: dr.data['quote'],
                              validator: (value) => value.isEmpty
                                  ? 'Quote can\'t be empty'
                                  : null,
                              onChanged: (value) {
                                quoteEdited = value;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: textFormFieldDecoration.copyWith(
                                labelText: 'Author',
                              ),
                              // controller: lNameCtrlEdited,
                              initialValue: dr.data['author'],
                              validator: (value) => value.isEmpty
                                  ? 'Author name can\'t be empty'
                                  : null,
                              onChanged: (value) {
                                authorEdited = value;
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      child: Text('update'),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formKey12.currentState.validate()) {
                          dynamic result = await fds.updateQuote(
                            quoteEdited,
                            authorEdited,
                          );
                          if (result) {
                            setState(() {
                              loading = false;
                              error = 'Quote updated successfully';
                              showSuccessAlertDialog(context, error);
                              isRecordAvailable = false;
                            });
                          } else {
                            loading = false;
                            error = 'Quote updation failed';
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: RaisedButton(
                        child: Text('Update Quote'),
                        onPressed: () async {
                          dynamic result = await fds.getQuoteInfo();
                          if (!(result == null)) {
                            setState(() {
                              dr = result;
                              isRecordAvailable = true;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
  }
}
