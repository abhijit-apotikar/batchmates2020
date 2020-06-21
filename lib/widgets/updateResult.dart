import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../class/colorCodeNotifier.dart';
import '../services/firestoreDatabaseService.dart';
import '../widgets/successAlertDialog.dart';
import '../widgets/failureAlertDialog.dart';

import '../shared.dart/constants.dart';

class UpdateResult extends StatefulWidget {
  @override
  _UpdateResultState createState() => _UpdateResultState();
}

class _UpdateResultState extends State<UpdateResult> {

   

  final _formKey7 = new GlobalKey<FormState>();
  final _formKey8 = new GlobalKey<FormState>();

  FirestoreDatabaseService fds = new FirestoreDatabaseService();

  bool isRecordAvailable = false;
  var dr;

  String error = '';

  String fName = '';
  String lName = '';
  String fNameEdited = '';
  String lNameEdited = '';
  String statIntEdited = '';
  final fNameCtrl = new TextEditingController();
  final lNameCtrl = new TextEditingController();
  String examDropdownValue = 'bscSem1W2017';
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    return isRecordAvailable
        ? Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'The textfields contain the current values, you can edit them by clicking them and then press the submit button to perform an update.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Form(
                    key: _formKey8,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: textFormFieldDecoration.copyWith(
                            labelText: 'First Name',
                          ),
                          validator: (value) => value.isEmpty
                              ? 'First name can\'t be empty'
                              : null,
                          initialValue: dr.data
                                  .containsKey('bscSem1W2017_fName')
                              ? dr.data['bscSem1W2017_fName']
                              : (dr.data.containsKey('bscSem2S2018_fName')
                                  ? dr.data['bscSem2S2018_fName']
                                  : (dr.data.containsKey('bscSem3W2018_fName')
                                      ? dr.data['bscSem3W2018_fName']
                                      : (dr.data
                                              .containsKey('bscSem4S2019_fName')
                                          ? dr.data['bscSem4S2019']
                                          : (dr.data['bscSem5W2019_fName'])))),
                          onChanged: (value) {
                            fNameEdited = value;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textFormFieldDecoration.copyWith(
                            labelText: 'Last Name',
                          ),
                          validator: (value) => value.isEmpty
                              ? 'Last name can\'t be empty'
                              : null,
                          initialValue: dr.data
                                  .containsKey('bscSem1W2017_lName')
                              ? dr.data['bscSem1W2017_lName']
                              : (dr.data.containsKey('bscSem2S2018_lName')
                                  ? dr.data['bscSem2S2018_lName']
                                  : (dr.data.containsKey('bscSem3W2018_lName')
                                      ? dr.data['bscSem3W2018_lName']
                                      : (dr.data
                                              .containsKey('bscSem4S2019_lName')
                                          ? dr.data['bscSem4S2019']
                                          : (dr.data['bscSem5W2019_lName'])))),
                          onChanged: (value) {
                            fNameEdited = value;
                          },
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Text(dr.data.containsKey('stat')
                        //         ? 'Stastics'
                        //         : (dr.data.containsKey('phy')
                        //             ? 'Physics'
                        //             : (dr.data.containsKey('elec')
                        //                 ? 'Electronics'
                        //                 : (dr.data.containsKey('chem')
                        //                     ? 'Chemistry'
                        //                     : (dr.data.containsKey('maths')
                        //                         ? 'Mathematics'
                        //                         : 'Computer Science'))))),
                            SizedBox(
                              height: 10.0,
                            ),
                            dr.data['subComb'] == 'smcs'
                                ? Container(
                                //  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                       children: <Widget>[
                                          Text('Statistics'),
                                       ],),
                                       SizedBox(
                                         height: 10.0,
                                       ),
                                      
                                         TextFormField(
                                           keyboardType: TextInputType.number,
                                           decoration: textFormFieldDecoration.copyWith(labelText: 'Stat internal'),
                                           initialValue: dr.data['stat'] == -1 ? 'null' : dr.data['stat']['statInt'].toString(),
                                           validator: (value) => value.isEmpty ? 'marks can\'t be empty' : null,
                                           onChanged: (value){
                                              statIntEdited = value;
                                           },
                                         ),
                                     
                                    ],
                                  ),
                                )
                                : (dr.data['subComb'] == 'pmcs'
                                    ? Container()
                                    : (dr.data['subComb'] == 'pecs'
                                        ? Container()
                                        : (dr.data['subComb'] == 'secs'
                                            ? Container()
                                            : (dr.data['subComb'] == 'pccs'
                                                ? Container()
                                                : (dr.data['subComb'] == 'pme'
                                                    ? Container()
                                                    : Container()))))),
                         
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey7,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: textFormFieldDecoration.copyWith(
                        hintText: 'First Name'),
                    validator: (value) =>
                        value.isEmpty ? 'First name can\'t be empty' : null,
                    onChanged: (value) {
                      fName = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration:
                        textFormFieldDecoration.copyWith(hintText: 'Last Name'),
                    validator: (value) =>
                        value.isEmpty ? 'Last name can\'t be empty' : null,
                    onChanged: (value) {
                      lName = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Batch: '),
                      DropdownButton<String>(
                        value: examDropdownValue,
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
                            examDropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          'bscSem1W2017',
                          'bscSem2S2018',
                          'bscSem3W2018',
                          'bscSem4S2019',
                          'bscSem5W2019',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    child: Text('Get Record'),
                    onPressed: () async {
                      if (_formKey7.currentState.validate()) {
                        dynamic result = await fds.getResultRecord(
                            fName, lName, examDropdownValue);
                        if (!(result == null)) {
                          setState(() {
                            isRecordAvailable = true;
                            dr = result;
                          });
                        } else {
                          setState(() {
                            error = 'Requested result not found';
                            showFailureAlertDialog(context, error);
                            fNameCtrl.clear();
                            lNameCtrl.clear();
                            examDropdownValue = 'bscSem1W2017';
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
