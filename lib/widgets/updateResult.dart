import 'package:flutter/material.dart';
import 'package:gradbatch2020/widgets/successAlertDialog.dart';

import '../services/firestoreDatabaseService.dart';

import '../widgets/failureAlertDialog.dart';

import '../shared.dart/constants.dart';
import '../widgets/loadingWidget.dart';

class UpdateResult extends StatefulWidget {
  @override
  _UpdateResultState createState() => _UpdateResultState();
}

class _UpdateResultState extends State<UpdateResult> {
  bool loading = false;
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
  String statThEdited = '';
  String statPractEdited = '';

  String phyIntEdited = '';
  String phyThEdited = '';
  String phyPractEdited = '';

  String elecIntEdited = '';
  String elecThEdited = '';
  String elecPractEdited = '';

  String chemIntEdited = '';
  String chemThEdited = '';
  String chemPractEdited = '';

  String compIntEdited = '';
  String compThEdited = '';
  String compPractEdited = '';

  String maths1IntEdited = '';
  String maths1ThEdited = '';
  String maths2IntEdited = '';
  String maths2ThEdited = '';

  final fNameCtrl = new TextEditingController();
  final lNameCtrl = new TextEditingController();
  String examDropdownValue = 'bscSem1W2017';
  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget()
        : (isRecordAvailable
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
                            Row(
                              children: <Widget>[
                                Text(
                                  'Name:  ',
                                  style: TextStyle(
                                      fontFamily: 'Nunito', fontSize: 18),
                                ),
                                Text(
                                  '${dr.data.containsKey('bscSem1W2017_fName') ? dr.data['bscSem1W2017_fName'] : (dr.data.containsKey('bscSem2S2018_fName') ? dr.data['bscSem2S2018_fName'] : (dr.data.containsKey('bscSem3W2018_fName') ? dr.data['bscSem3W2018_fName'] : (dr.data.containsKey('bscSem4S2019_fName') ? dr.data['bscSem4S2019'] : (dr.data['bscSem5W2019_fName']))))}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'Typewriter', fontSize: 18),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${dr.data.containsKey('bscSem1W2017_lName') ? dr.data['bscSem1W2017_lName'] : (dr.data.containsKey('bscSem2S2018_lName') ? dr.data['bscSem2S2018_lName'] : (dr.data.containsKey('bscSem3W2018_lName') ? dr.data['bscSem3W2018_lName'] : (dr.data.containsKey('bscSem4S2019_lName') ? dr.data['bscSem4S2019'] : (dr.data['bscSem5W2019_lName']))))}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'Typewriter', fontSize: 18),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 15.0,
                            ),

                            ///// SMCS -------------------------------------
                            dr.data['subComb'] == 'smcs'
                                ? Container(
                                    //  height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        // smcs stat--------------------
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '***** Statistics *****',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                                  labelText: 'Stat internal'),
                                          initialValue: (dr.data['stat']
                                                      ['statInt'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['stat']['statInt']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 20)
                                              ? 'Statistics internal marks should be in between 0 and 20'
                                              : null,
                                          onChanged: (value) {
                                            statIntEdited = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Stat theory',
                                          ),
                                          initialValue: (dr.data['stat']
                                                      ['statTh'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['stat']['statTh']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 80)
                                              ? 'Statistics theory marks should be in between 0 and 80'
                                              : null,
                                          onChanged: (value) {
                                            statThEdited = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Stat practical',
                                          ),
                                          initialValue: (dr.data['stat']
                                                      ['statPract'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['stat']['statPract']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 50)
                                              ? 'Statistics paractical marks should be in between 0 and 50'
                                              : null,
                                          onChanged: (value) {
                                            statPractEdited = value;
                                          },
                                        ),

                                        // stat maths -------------------------------
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '***** Mathematics *****',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Maths1 internal',
                                          ),
                                          initialValue: (dr.data['maths']
                                                      ['maths1Int'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['maths']['maths1Int']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 15)
                                              ? 'Maths1 internal marks should be in between 0 and 15'
                                              : null,
                                          onChanged: (value) {
                                            maths1IntEdited = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Maths1 theory',
                                          ),
                                          initialValue: (dr.data['maths']
                                                      ['maths1Th'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['maths']['maths1Th']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 60)
                                              ? 'Maths1 theory marks should be in between 0 and 60'
                                              : null,
                                          onChanged: (value) {
                                            maths1ThEdited = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Maths2 internal',
                                          ),
                                          initialValue: (dr.data['maths']
                                                      ['maths2Int'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['maths']['maths2Int']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 15)
                                              ? 'Maths2 internal marks should be in between 0 and 15'
                                              : null,
                                          onChanged: (value) {
                                            maths2IntEdited = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Maths2 theory',
                                          ),
                                          initialValue: (dr.data['maths']
                                                      ['maths2Th'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['maths']['maths2Th']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 60)
                                              ? 'Maths2 theory marks should be in between 0 and 60'
                                              : null,
                                          onChanged: (value) {
                                            maths2ThEdited = value;
                                          },
                                        ),

                                        // smcs comp----------------
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '***** Computer Science *****',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Comp internal',
                                          ),
                                          initialValue: (dr.data['comp']
                                                      ['compInt'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['comp']['compInt']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 20)
                                              ? 'Computer internal marks should be in between 0 and 20'
                                              : null,
                                          onChanged: (value) {
                                            compIntEdited = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Comp theory',
                                          ),
                                          initialValue: (dr.data['comp']
                                                      ['compTh'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['comp']['compTh']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 80)
                                              ? 'Computer theory marks should be in between 0 and 80'
                                              : null,
                                          onChanged: (value) {
                                            compThEdited = value;
                                          },
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        TextFormField(
                                          style: myTextFormFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              textFormFieldDecoration.copyWith(
                                            labelText: 'Comp practical',
                                          ),
                                          initialValue: (dr.data['comp']
                                                      ['compPract'] ==
                                                  (-1))
                                              ? 'null'
                                              : dr.data['comp']['compPract']
                                                  .toString(),
                                          validator: (value) => !(int.parse(
                                                          value) >=
                                                      0 &&
                                                  int.parse(value) <= 50)
                                              ? 'Computer practical marks should be in between 0 and 50'
                                              : null,
                                          onChanged: (value) {
                                            compPractEdited = value;
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ///// PMCS---------------------------------
                                : (dr.data['subComb'] == 'pmcs'
                                    ? Container(
                                        //  height: 200,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            // pmcs physics--------------------
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '***** Physics *****',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Physics internal',
                                              ),
                                              initialValue: (dr.data['phy']
                                                          ['phyInt'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['phy']['phyInt']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 20)
                                                  ? 'Physics internal marks should be in between 0 and 20'
                                                  : null,
                                              onChanged: (value) {
                                                phyIntEdited = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Physics theory',
                                              ),
                                              initialValue: (dr.data['phy']
                                                          ['phyTh'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['phy']['phyTh']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 80)
                                                  ? 'Physics theory marks should be in between 0 and 80'
                                                  : null,
                                              onChanged: (value) {
                                                phyThEdited = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Physics practical',
                                              ),
                                              initialValue: (dr.data['phy']
                                                          ['phyPract'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['phy']['phyPract']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 50)
                                                  ? 'Physics practical marks should be in between 0 and 50'
                                                  : null,
                                              onChanged: (value) {
                                                phyPractEdited = value;
                                              },
                                            ),

                                            // pmcs maths -------------------------------
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '***** Mathematics *****',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Maths1 internal',
                                              ),
                                              initialValue: (dr.data['maths']
                                                          ['maths1Int'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['maths']
                                                          ['maths1Int']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 15)
                                                  ? 'Maths1 internal marks should be in between 0 and 15'
                                                  : null,
                                              onChanged: (value) {
                                                maths1IntEdited = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Maths1 theory',
                                              ),
                                              initialValue: (dr.data['maths']
                                                          ['maths1Th'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['maths']['maths1Th']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 60)
                                                  ? 'Maths1 theory marks should be in between 0 and 60'
                                                  : null,
                                              onChanged: (value) {
                                                maths1ThEdited = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Maths2 internal',
                                              ),
                                              initialValue: (dr.data['maths']
                                                          ['maths2Int'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['maths']
                                                          ['maths2Int']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 15)
                                                  ? 'Maths2 internal marks should be in between 0 and 15'
                                                  : null,
                                              onChanged: (value) {
                                                maths2IntEdited = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Maths2 theory',
                                              ),
                                              initialValue: (dr.data['maths']
                                                          ['maths2Th'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['maths']['maths2Th']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 60)
                                                  ? 'Maths2 theory marks should be in between 0 and 60'
                                                  : null,
                                              onChanged: (value) {
                                                maths2ThEdited = value;
                                              },
                                            ),

                                            // pmcs comp----------------
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '***** Computer Science *****',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Comp internal',
                                              ),
                                              initialValue: (dr.data['comp']
                                                          ['compInt'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['comp']['compInt']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 20)
                                                  ? 'Computer internal marks should be in between 0 and 20'
                                                  : null,
                                              onChanged: (value) {
                                                compIntEdited = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Comp theory',
                                              ),
                                              initialValue: (dr.data['comp']
                                                          ['compTh'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['comp']['compTh']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 80)
                                                  ? 'Computer theory marks should be in between 0 and 80'
                                                  : null,
                                              onChanged: (value) {
                                                compThEdited = value;
                                              },
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              style: myTextFormFieldTextStyle,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration:
                                                  textFormFieldDecoration
                                                      .copyWith(
                                                labelText: 'Comp practical',
                                              ),
                                              initialValue: (dr.data['comp']
                                                          ['compPract'] ==
                                                      (-1))
                                                  ? 'null'
                                                  : dr.data['comp']['compPract']
                                                      .toString(),
                                              validator: (value) => !(int.parse(
                                                              value) >=
                                                          0 &&
                                                      int.parse(value) <= 50)
                                                  ? 'Computer practical marks should be in between 0 and 50'
                                                  : null,
                                              onChanged: (value) {
                                                compPractEdited = value;
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    // PECS--------------------------------
                                    : (dr.data['subComb'] == 'pecs'
                                        ? Container(
                                            //  height: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                // pecs physics--------------------
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '***** Physics *****',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText:
                                                        'Physics internal',
                                                  ),
                                                  initialValue: (dr.data['phy']
                                                              ['phyInt'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['phy']['phyInt']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              20)
                                                      ? 'Physics internal marks should be in between 0 and 20'
                                                      : null,
                                                  onChanged: (value) {
                                                    phyIntEdited = value;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText: 'Physics theory',
                                                  ),
                                                  initialValue: (dr.data['phy']
                                                              ['phyTh'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['phy']['phyTh']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              80)
                                                      ? 'Physics theory marks should be in between 0 and 80'
                                                      : null,
                                                  onChanged: (value) {
                                                    phyThEdited = value;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText:
                                                        'Physics practical',
                                                  ),
                                                  initialValue: (dr.data['phy']
                                                              ['phyPract'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['phy']
                                                              ['phyPract']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              50)
                                                      ? 'Physics practical marks should be in between 0 and 50'
                                                      : null,
                                                  onChanged: (value) {
                                                    phyPractEdited = value;
                                                  },
                                                ),

                                                // pecs electronics -------------------------------
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '***** Electronics *****',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText:
                                                        'Electronics internal',
                                                  ),
                                                  initialValue: (dr.data['elec']
                                                              ['elecInt'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['elec']
                                                              ['elecInt']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              20)
                                                      ? 'Electronics internal marks should be in between 0 and 20'
                                                      : null,
                                                  onChanged: (value) {
                                                    elecIntEdited = value;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText:
                                                        'Electronics theory',
                                                  ),
                                                  initialValue: (dr.data['elec']
                                                              ['elecTh'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['elec']
                                                              ['elecTh']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              80)
                                                      ? 'Maths1 theory marks should be in between 0 and 80'
                                                      : null,
                                                  onChanged: (value) {
                                                    elecThEdited = value;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText:
                                                        'Electronics practical',
                                                  ),
                                                  initialValue: (dr.data['elec']
                                                              ['elecPract'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['elec']
                                                              ['elecPract']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              50)
                                                      ? 'Maths2 internal marks should be in between 0 and 50'
                                                      : null,
                                                  onChanged: (value) {
                                                    elecPractEdited = value;
                                                  },
                                                ),

                                                // pecs comp----------------
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '***** Computer Science *****',
                                                      style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText: 'Comp internal',
                                                  ),
                                                  initialValue: (dr.data['comp']
                                                              ['compInt'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['comp']
                                                              ['compInt']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              20)
                                                      ? 'comp internal marks should be in between 0 and 20'
                                                      : null,
                                                  onChanged: (value) {
                                                    compIntEdited = value;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText: 'Comp theory',
                                                  ),
                                                  initialValue: (dr.data['comp']
                                                              ['compTh'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['comp']
                                                              ['compTh']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              80)
                                                      ? 'comp theory marks should be in between 0 and 80'
                                                      : null,
                                                  onChanged: (value) {
                                                    compThEdited = value;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                TextFormField(
                                                  style:
                                                      myTextFormFieldTextStyle,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      textFormFieldDecoration
                                                          .copyWith(
                                                    labelText: 'Comp practical',
                                                  ),
                                                  initialValue: (dr.data['comp']
                                                              ['compPract'] ==
                                                          (-1))
                                                      ? 'null'
                                                      : dr.data['comp']
                                                              ['compPract']
                                                          .toString(),
                                                  validator: (value) => !(int
                                                                  .parse(
                                                                      value) >=
                                                              0 &&
                                                          int.parse(value) <=
                                                              50)
                                                      ? 'Comp practical marks should be in between 0 and 50'
                                                      : null,
                                                  onChanged: (value) {
                                                    compPractEdited = value;
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        // SECS------------------------
                                        : (dr.data['subComb'] == 'secs'
                                            ? Container(
                                                //  height: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    // secs physics--------------------
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          '***** Statistics *****',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Statistics internal',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'stat']
                                                                  ['statInt'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['stat']
                                                                  ['statInt']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  20)
                                                          ? 'Statistics internal marks should be in between 0 and 20'
                                                          : null,
                                                      onChanged: (value) {
                                                        statIntEdited = value;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Statistics theory',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'stat']
                                                                  ['statTh'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['stat']
                                                                  ['statTh']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  80)
                                                          ? 'Statistics theory marks should be in between 0 and 80'
                                                          : null,
                                                      onChanged: (value) {
                                                        statThEdited = value;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Statistics practical',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'stat'][
                                                                  'statPract'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['stat']
                                                                  ['statPract']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  50)
                                                          ? 'Statistics practical marks should be in between 0 and 50'
                                                          : null,
                                                      onChanged: (value) {
                                                        statPractEdited = value;
                                                      },
                                                    ),

                                                    // secs electronics -------------------------------
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          '***** Electronics *****',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Electronics internal',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'elec']
                                                                  ['elecInt'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['elec']
                                                                  ['elecInt']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  20)
                                                          ? 'Electronics internal marks should be in between 0 and 20'
                                                          : null,
                                                      onChanged: (value) {
                                                        elecIntEdited = value;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Electronics theory',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'elec']
                                                                  ['elecTh'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['elec']
                                                                  ['elecTh']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  80)
                                                          ? 'Electronics theory marks should be in between 0 and 80'
                                                          : null,
                                                      onChanged: (value) {
                                                        elecThEdited = value;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Electronics practical',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'elec'][
                                                                  'elecPract'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['elec']
                                                                  ['elecPract']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  50)
                                                          ? 'Electronics practical marks should be in between 0 and 50'
                                                          : null,
                                                      onChanged: (value) {
                                                        elecPractEdited = value;
                                                      },
                                                    ),

                                                    // secs comp----------------
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          '***** Computer Science *****',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Comp internal',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'comp']
                                                                  ['compInt'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['comp']
                                                                  ['compInt']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  20)
                                                          ? 'comp internal marks should be in between 0 and 20'
                                                          : null,
                                                      onChanged: (value) {
                                                        compIntEdited = value;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Comp theory',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'comp']
                                                                  ['compTh'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['comp']
                                                                  ['compTh']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  80)
                                                          ? 'comp theory marks should be in between 0 and 80'
                                                          : null,
                                                      onChanged: (value) {
                                                        compThEdited = value;
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    TextFormField(
                                                      style:
                                                          myTextFormFieldTextStyle,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          textFormFieldDecoration
                                                              .copyWith(
                                                        labelText:
                                                            'Comp practical',
                                                      ),
                                                      initialValue: (dr.data[
                                                                      'comp'][
                                                                  'compPract'] ==
                                                              (-1))
                                                          ? 'null'
                                                          : dr.data['comp']
                                                                  ['compPract']
                                                              .toString(),
                                                      validator: (value) => (int
                                                                      .parse(
                                                                          value) >=
                                                                  0 &&
                                                              int.parse(
                                                                      value) <=
                                                                  50)
                                                          ? 'Comp practical marks should be in between 0 and 50'
                                                          : null,
                                                      onChanged: (value) {
                                                        compPractEdited = value;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )

                                            /// PCCS--------------------------------------
                                            : (dr.data['subComb'] == 'pccs'
                                                ? Container(
                                                    //  height: 200,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        // pccs physics--------------------
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              '***** Physics *****',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Physics internal',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'phy']
                                                                      [
                                                                      'phyInt'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['phy']
                                                                      ['phyInt']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          20)
                                                                  ? 'Physics internal marks should be in between 0 and 20'
                                                                  : null,
                                                          onChanged: (value) {
                                                            phyIntEdited =
                                                                value;
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Physics theory',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'phy']
                                                                      [
                                                                      'phyTh'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['phy']
                                                                      ['phyTh']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          80)
                                                                  ? 'Physics theory marks should be in between 0 and 80'
                                                                  : null,
                                                          onChanged: (value) {
                                                            phyThEdited = value;
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Physics practical',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'phy']
                                                                      [
                                                                      'phyPract'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['phy'][
                                                                      'phyPract']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          50)
                                                                  ? 'Physics practical marks should be in between 0 and 50'
                                                                  : null,
                                                          onChanged: (value) {
                                                            phyPractEdited =
                                                                value;
                                                          },
                                                        ),

                                                        // pccs chemistry -------------------------------
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              '***** Chemistry *****',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Chemistry internal',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'chem']
                                                                      [
                                                                      'chemInt'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['chem'][
                                                                      'chemInt']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          20)
                                                                  ? 'Chemistry internal marks should be in between 0 and 20'
                                                                  : null,
                                                          onChanged: (value) {
                                                            chemIntEdited =
                                                                value;
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Chemistry theory',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'chem']
                                                                      [
                                                                      'chemTh'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['chem']
                                                                      ['chemTh']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          80)
                                                                  ? 'Chemistry theory marks should be in between 0 and 80'
                                                                  : null,
                                                          onChanged: (value) {
                                                            chemThEdited =
                                                                value;
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Chemistry practical',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'chem']
                                                                      [
                                                                      'chemPract'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['chem'][
                                                                      'chemPract']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          50)
                                                                  ? 'Chemistry practical marks should be in between 0 and 50'
                                                                  : null,
                                                          onChanged: (value) {
                                                            chemPractEdited =
                                                                value;
                                                          },
                                                        ),

                                                        // pccs comp----------------
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              '***** Computer Science *****',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Comp internal',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'comp']
                                                                      [
                                                                      'compInt'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['comp'][
                                                                      'compInt']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          20)
                                                                  ? 'comp internal marks should be in between 0 and 20'
                                                                  : null,
                                                          onChanged: (value) {
                                                            compIntEdited =
                                                                value;
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Comp theory',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'comp']
                                                                      [
                                                                      'compTh'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['comp']
                                                                      ['compTh']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          80)
                                                                  ? 'comp theory marks should be in between 0 and 80'
                                                                  : null,
                                                          onChanged: (value) {
                                                            compThEdited =
                                                                value;
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        TextFormField(
                                                          style:
                                                              myTextFormFieldTextStyle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              textFormFieldDecoration
                                                                  .copyWith(
                                                            labelText:
                                                                'Comp practical',
                                                          ),
                                                          initialValue: (dr.data[
                                                                          'comp']
                                                                      [
                                                                      'compPract'] ==
                                                                  (-1))
                                                              ? 'null'
                                                              : dr.data['comp'][
                                                                      'compPract']
                                                                  .toString(),
                                                          validator: (value) =>
                                                              (int.parse(value) >=
                                                                          0 &&
                                                                      int.parse(
                                                                              value) <=
                                                                          50)
                                                                  ? 'Comp practical marks should be in between 0 and 50'
                                                                  : null,
                                                          onChanged: (value) {
                                                            compPractEdited =
                                                                value;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ////// PME ------------------------------------
                                                : (dr.data['subComb'] == 'pme'
                                                    ? Container(
                                                        //  height: 200,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            // pme physics--------------------
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '***** Physics *****',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Physics internal',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'phy']
                                                                          [
                                                                          'phyInt'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'phy']
                                                                          [
                                                                          'phyInt']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              20)
                                                                      ? 'Physics internal marks should be in between 0 and 20'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                phyIntEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Physics theory',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'phy']
                                                                          [
                                                                          'phyTh'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'phy']
                                                                          [
                                                                          'phyTh']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              80)
                                                                      ? 'Physics theory marks should be in between 0 and 80'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                phyThEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Physics practical',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'phy']
                                                                          [
                                                                          'phyPract'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'phy']
                                                                          [
                                                                          'phyPract']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              50)
                                                                      ? 'Physics practical marks should be in between 0 and 50'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                phyPractEdited =
                                                                    value;
                                                              },
                                                            ),

                                                            // pme maths -------------------------------
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '***** Mathematics *****',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Maths1 internal',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'maths']
                                                                          [
                                                                          'maths1Int'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'maths']
                                                                          [
                                                                          'maths1Int']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              15)
                                                                      ? 'Maths1 internal marks should be in between 0 and 15'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                maths1IntEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Maths1 theory',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'maths']
                                                                          [
                                                                          'maths1Th'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'maths']
                                                                          [
                                                                          'maths1Th']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              60)
                                                                      ? 'Maths1 theory marks should be in between 0 and 60'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                maths1ThEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Maths2 internal',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'maths']
                                                                          [
                                                                          'maths2Int'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'maths']
                                                                          [
                                                                          'maths2Int']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              15)
                                                                      ? 'Maths2 internal marks should be in between 0 and 15'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                maths2IntEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Maths2 theory',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'maths']
                                                                          [
                                                                          'maths2Th'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'maths']
                                                                          [
                                                                          'maths2Th']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              60)
                                                                      ? 'Maths2 theory marks should be in between 0 and 60'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                maths2ThEdited =
                                                                    value;
                                                              },
                                                            ),

                                                            // pme elec----------------
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '***** Electronics *****',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Electronics internal',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'elec']
                                                                          [
                                                                          'elecInt'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'elec']
                                                                          [
                                                                          'elecInt']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              20)
                                                                      ? 'Electronics internal marks should be in between 0 and 20'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                elecIntEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Electronics theory',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'elec']
                                                                          [
                                                                          'elecTh'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'elec']
                                                                          [
                                                                          'elecTh']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              80)
                                                                      ? 'Electronics theory marks should be in between 0 and 80'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                elecThEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Electronics practical',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'elec']
                                                                          [
                                                                          'elecPract'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'elec']
                                                                          [
                                                                          'elecPract']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              50)
                                                                      ? 'Electronics practical marks should be in between 0 and 50'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                elecPractEdited =
                                                                    value;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ///// PCM -------------------------------------
                                                    : Container(
                                                        //  height: 200,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            // pcm physics--------------------
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '***** Physics *****',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Physics internal',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'phy']
                                                                          [
                                                                          'phyInt'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'phy']
                                                                          [
                                                                          'phyInt']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              20)
                                                                      ? 'Physics internal marks should be in between 0 and 20'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                phyIntEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Physics theory',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'phy']
                                                                          [
                                                                          'phyTh'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'phy']
                                                                          [
                                                                          'phyTh']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              80)
                                                                      ? 'Physics theory marks should be in between 0 and 80'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                phyThEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Physics practical',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'phy']
                                                                          [
                                                                          'phyPract'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'phy']
                                                                          [
                                                                          'phyPract']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              50)
                                                                      ? 'Physics practical marks should be in between 0 and 50'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                phyPractEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            // pcm chem----------------
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '***** Chemistry *****',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Chemistry internal',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'chem']
                                                                          [
                                                                          'chemInt'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'chem']
                                                                          [
                                                                          'chemInt']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              20)
                                                                      ? 'Chemistry internal marks should be in between 0 and 20'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                chemIntEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Chemistry theory',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'chem']
                                                                          [
                                                                          'chemTh'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'chem']
                                                                          [
                                                                          'chemTh']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              80)
                                                                      ? 'Chemistry theory marks should be in between 0 and 80'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                chemThEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Chemistry practical',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'chem']
                                                                          [
                                                                          'chemPract'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'chem']
                                                                          [
                                                                          'chemPract']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              50)
                                                                      ? 'Chemistry practical marks should be in between 0 and 50'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                chemPractEdited =
                                                                    value;
                                                              },
                                                            ),

                                                            // pcm maths -------------------------------
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '***** Mathematics *****',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Maths1 internal',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'maths']
                                                                          [
                                                                          'maths1Int'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'maths']
                                                                          [
                                                                          'maths1Int']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              15)
                                                                      ? 'Maths1 internal marks should be in between 0 and 15'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                maths1IntEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Maths1 theory',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'maths']
                                                                          [
                                                                          'maths1Th'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'maths']
                                                                          [
                                                                          'maths1Th']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              60)
                                                                      ? 'Maths1 theory marks should be in between 0 and 60'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                maths1ThEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Maths2 internal',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'maths']
                                                                          [
                                                                          'maths2Int'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'maths']
                                                                          [
                                                                          'maths2Int']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              15)
                                                                      ? 'Maths2 internal marks should be in between 0 and 15'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                maths2IntEdited =
                                                                    value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 5.0,
                                                            ),
                                                            TextFormField(
                                                              style:
                                                                  myTextFormFieldTextStyle,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  textFormFieldDecoration
                                                                      .copyWith(
                                                                labelText:
                                                                    'Maths2 theory',
                                                              ),
                                                              initialValue: (dr.data[
                                                                              'maths']
                                                                          [
                                                                          'maths2Th'] ==
                                                                      (-1))
                                                                  ? 'null'
                                                                  : dr.data[
                                                                          'maths']
                                                                          [
                                                                          'maths2Th']
                                                                      .toString(),
                                                              validator: (value) =>
                                                                  !(int.parse(value) >=
                                                                              0 &&
                                                                          int.parse(value) <=
                                                                              60)
                                                                      ? 'Maths2 theory marks should be in between 0 and 60'
                                                                      : null,
                                                              onChanged:
                                                                  (value) {
                                                                maths2ThEdited =
                                                                    value;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )))))),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton(
                              child: Text(
                                'Update',
                                style: TextStyle(fontFamily: 'Nunito'),
                              ),
                              onPressed: () async {
                                if (_formKey8.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result;
                                  if (dr.data['subComb'] == 'smcs') {
                                    result = await fds.updateSmcsResult(
                                      dr.documentID,
                                      examDropdownValue,
                                      statIntEdited: int.parse(statIntEdited),
                                      statThEdited: int.parse(statThEdited),
                                      statPractEdited:
                                          int.parse(statPractEdited),
                                      maths1IntEdited:
                                          int.parse(maths1IntEdited),
                                      maths1ThEdited: int.parse(maths1ThEdited),
                                      maths2IntEdited:
                                          int.parse(maths2IntEdited),
                                      maths2ThEdited: int.parse(maths2ThEdited),
                                      compIntEdited: int.parse(compIntEdited),
                                      compThEdited: int.parse(compThEdited),
                                      compPractEdited:
                                          int.parse(compPractEdited),
                                    );
                                  }
                                  if (dr.data['subComb'] == 'pmcs') {
                                    result = await fds.updatePmcsResult(
                                      dr.documentID,
                                      examDropdownValue,
                                      phyIntEdited: int.parse(phyIntEdited),
                                      phyThEdited: int.parse(phyThEdited),
                                      phyPractEdited: int.parse(phyPractEdited),
                                      maths1IntEdited:
                                          int.parse(maths1IntEdited),
                                      maths1ThEdited: int.parse(maths1ThEdited),
                                      maths2IntEdited:
                                          int.parse(maths2IntEdited),
                                      maths2ThEdited: int.parse(maths2ThEdited),
                                      compIntEdited: int.parse(compIntEdited),
                                      compThEdited: int.parse(compThEdited),
                                      compPractEdited:
                                          int.parse(compPractEdited),
                                    );
                                  }
                                  if (dr.data['subComb'] == 'pecs') {
                                    result = await fds.updatePecsResult(
                                      dr.documentID,
                                      examDropdownValue,
                                      phyIntEdited: int.parse(phyIntEdited),
                                      phyThEdited: int.parse(phyThEdited),
                                      phyPractEdited: int.parse(phyPractEdited),
                                      elecIntEdited: int.parse(elecIntEdited),
                                      elecThEdited: int.parse(elecThEdited),
                                      elecPractEdited:
                                          int.parse(elecPractEdited),
                                      compIntEdited: int.parse(compIntEdited),
                                      compThEdited: int.parse(compThEdited),
                                      compPractEdited:
                                          int.parse(compPractEdited),
                                    );
                                  }
                                  if (dr.data['subComb'] == 'secs') {
                                    result = await fds.updateSecsResult(
                                      dr.documentID,
                                      examDropdownValue,
                                      statIntEdited: int.parse(statIntEdited),
                                      statThEdited: int.parse(statThEdited),
                                      statPractEdited:
                                          int.parse(statPractEdited),
                                      elecIntEdited: int.parse(elecIntEdited),
                                      elecThEdited: int.parse(elecThEdited),
                                      elecPractEdited:
                                          int.parse(elecPractEdited),
                                      compIntEdited: int.parse(compIntEdited),
                                      compThEdited: int.parse(compThEdited),
                                      compPractEdited:
                                          int.parse(compPractEdited),
                                    );
                                  }
                                  if (dr.data['subComb'] == 'pccs') {
                                    result = await fds.updatePccsResult(
                                      dr.documentID,
                                      examDropdownValue,
                                      phyIntEdited: int.parse(phyIntEdited),
                                      phyThEdited: int.parse(phyThEdited),
                                      phyPractEdited: int.parse(phyPractEdited),
                                      chemIntEdited: int.parse(chemIntEdited),
                                      chemThEdited: int.parse(chemThEdited),
                                      chemPractEdited:
                                          int.parse(chemPractEdited),
                                      compIntEdited: int.parse(compIntEdited),
                                      compThEdited: int.parse(compThEdited),
                                      compPractEdited:
                                          int.parse(compPractEdited),
                                    );
                                  }
                                  if (dr.data['subComb'] == 'pme') {
                                    result = await fds.updatePmeResult(
                                      dr.documentID,
                                      examDropdownValue,
                                      phyIntEdited: int.parse(phyIntEdited),
                                      phyThEdited: int.parse(phyThEdited),
                                      phyPractEdited: int.parse(phyPractEdited),
                                      maths1IntEdited:
                                          int.parse(maths1IntEdited),
                                      maths1ThEdited: int.parse(maths1ThEdited),
                                      maths2IntEdited:
                                          int.parse(maths2IntEdited),
                                      maths2ThEdited: int.parse(maths2ThEdited),
                                      elecIntEdited: int.parse(elecIntEdited),
                                      elecThEdited: int.parse(elecThEdited),
                                      elecPractEdited:
                                          int.parse(elecPractEdited),
                                    );
                                  }
                                  if (dr.data['subComb'] == 'pcm') {
                                    result = await fds.updatePcmResult(
                                      dr.documentID,
                                      examDropdownValue,
                                      phyIntEdited: int.parse(phyIntEdited),
                                      phyThEdited: int.parse(phyThEdited),
                                      phyPractEdited: int.parse(phyPractEdited),
                                      maths1IntEdited:
                                          int.parse(maths1IntEdited),
                                      maths1ThEdited: int.parse(maths1ThEdited),
                                      maths2IntEdited:
                                          int.parse(maths2IntEdited),
                                      maths2ThEdited: int.parse(maths2ThEdited),
                                      chemIntEdited: int.parse(chemIntEdited),
                                      chemThEdited: int.parse(chemThEdited),
                                      chemPractEdited:
                                          int.parse(chemPractEdited),
                                    );
                                  }
                                  if (result == true) {
                                    setState(() {
                                      loading = false;
                                      error = 'Result updated successfully';
                                      showSuccessAlertDialog(context, error);
                                      statIntEdited = '';
                                      statThEdited = '';
                                      statPractEdited = '';
                                      phyIntEdited = '';
                                      phyThEdited = '';
                                      phyPractEdited = '';
                                      elecIntEdited = '';
                                      elecThEdited = '';
                                      elecPractEdited = '';
                                      chemIntEdited = '';
                                      chemThEdited = '';
                                      chemPractEdited = '';
                                      compIntEdited = '';
                                      compThEdited = '';
                                      compPractEdited = '';
                                      maths1IntEdited = '';
                                      maths1ThEdited = '';
                                      maths2IntEdited = '';
                                      maths2ThEdited = '';
                                      isRecordAvailable = false;
                                    });
                                  } else {
                                    setState(() {
                                      loading = false;
                                      error = 'Sorry, Result updation failed';
                                      showFailureAlertDialog(context, error);
                                      statIntEdited = '';
                                      statThEdited = '';
                                      statPractEdited = '';
                                      phyIntEdited = '';
                                      phyThEdited = '';
                                      phyPractEdited = '';
                                      elecIntEdited = '';
                                      elecThEdited = '';
                                      elecPractEdited = '';
                                      chemIntEdited = '';
                                      chemThEdited = '';
                                      chemPractEdited = '';
                                      compIntEdited = '';
                                      compThEdited = '';
                                      compPractEdited = '';
                                      maths1IntEdited = '';
                                      maths1ThEdited = '';
                                      maths2IntEdited = '';
                                      maths2ThEdited = '';
                                      isRecordAvailable = false;
                                    });
                                  }
                                }
                              },
                            ),
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
                        style: myTextFormFieldTextStyle,
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
                        style: myTextFormFieldTextStyle,
                        decoration: textFormFieldDecoration.copyWith(
                            hintText: 'Last Name'),
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
                        child: Text(
                          'Get Record',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                        onPressed: () async {
                          if (_formKey7.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await fds.getResultRecord(
                                fName, lName, examDropdownValue);
                            if (!(result == null)) {
                              setState(() {
                                loading = false;
                                isRecordAvailable = true;
                                dr = result;
                              });
                            } else {
                              setState(() {
                                loading = false;
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
              ));
  }
}
