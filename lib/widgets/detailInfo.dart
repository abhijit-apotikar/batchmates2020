import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../class/argumentsForDetailInfo.dart';
import '../class/colorCodeNotifier.dart';
import '../data/mainData.dart';
import '../data/result/bscSem1w17.dart';
import '../data/result/bscSem2s18.dart';
import '../data/result/bscSem3w18.dart';
import '../data/result/bscSem4s19.dart';
import '../data/result/bscSem5w19.dart';

import '../class/marksDataModel.dart';
import '../class/marksDataObj.dart';
import './batchChart.dart';
import '../services/serviceToChart.dart';
import '../services/creatingMarksObj.dart';
import '../services/creatingChartData.dart';

final backgroundColor = Colors.white;
final appBarForeground = Colors.deepOrangeAccent;
final appBarBackground = Colors.white;
final appBarArea = Colors.white;

class DetailInfo extends StatefulWidget {
  @override
  _DetailInfoState createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  String dropdownValue = 'Sem 1';
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    RouteSettings settings = ModalRoute.of(context).settings;
    ArgumentsForDetailInfo nameInfo = settings.arguments;

    final Size size = MediaQuery.of(context).size;

    final data = nameInfo.data;
    final fname = nameInfo.fname;
    print(fname);
    final lname = nameInfo.lname;

    var exactData = mainData
        .where(
            (student) => student['fname'] == fname && student['lname'] == lname)
        .toList();
    // var exactfname = exactData[0]['fname'];
    // var exactlname = exactData[0]['lname'];
    var batch = exactData[0]['batch'];
    // var imgUrl = exactData[0]['imgUrl'];
    // var gender = exactData[0]['gender'];

    int batchIdx;
    if (batch == 'M1')
      batchIdx = 1;
    else if (batch == 'M2')
      batchIdx = 2;
    else if (batch == 'M3')
      batchIdx = 3;
    else if (batch == 'M4')
      batchIdx = 4;
    else if (batch == 'M5')
      batchIdx = 5;
    else if (batch == 'M6')
      batchIdx = 6;
    else if (batch == 'M7') batchIdx = 7;

    ServiceToChart stc = ServiceToChart(fname, lname);
    CreatingMarksObj cmo = CreatingMarksObj(batchIdx);
    CreatingChartData ccd = CreatingChartData(batchIdx);

    var exactMarksData1 = stc.returnExactRecord(marksData);
    var exactMarksData2 = stc.returnExactRecord(marksData2);
    var exactMarksData3 = stc.returnExactRecord(marksData3);
    var exactMarksData4 = stc.returnExactRecord(marksData4);
    var exactMarksData5 = stc.returnExactRecord(marksData5);
    //print(exactMarksData2[0]['sem']);

    Marks marks1 = cmo.returnMarksObj(exactMarksData1);
    Marks marks2 = cmo.returnMarksObj(exactMarksData2);
    Marks marks3 = cmo.returnMarksObj(exactMarksData3);
    Marks marks4 = cmo.returnMarksObj(exactMarksData4);
    Marks marks5 = cmo.returnMarksObj(exactMarksData5);

    final List<MarksData> chartData1 = ccd.returnChartData(marks1);
    final List<MarksData> chartData2 = ccd.returnChartData(marks2);
    final List<MarksData> chartData3 = ccd.returnChartData(marks3);
    final List<MarksData> chartData4 = ccd.returnChartData(marks4);
    final List<MarksData> chartData5 = ccd.returnChartData(marks5);

    return Scaffold(
      backgroundColor: localColorCode.ccBackgroundColor,
      appBar: AppBar(
        iconTheme: new IconThemeData(
          color: localColorCode.ccAppBarForegroundColor,
          size: 28,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text(
          '${data['fName']} + ' ' + ${data['lName']}',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: localColorCode.ccAppBarForegroundColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (size.height) * 0.4,
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: data['gender'] == 'male'
                      ? AssetImage('assets/images/sbman.png')
                      : AssetImage('assets/images/woman.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              //height: (size.height) * 0.67,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: localColorCode.ccBackgroundColor,
              child: Card(
                elevation: 3,
                color: localColorCode.ccBackgroundColor,
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: localColorCode.ccAppBarForegroundColor,
                    width: 1.0,
                  ),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Name: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            '${data['fName']} ${data['lName']}',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Batch: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            '${data['batch']}',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Gender: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            '${data['gender']}',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Mobile No.: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            'null',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Address: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            ' Landmark: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            'null',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            ' Locality: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            'null',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            ' City/Village: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            'null',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            ' Pin Code: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            'null',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Hobbies: ',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            'null',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Row(children: <Widget>[
                Text(
                  'Semester Marks',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Sem 1', 'Sem 2', 'Sem 3', 'Sem 4', 'Sem 5']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  ChartWidget(chartData1, exactMarksData1[0]['sem'], batchIdx),
                  SizedBox(
                    height: 30,
                  ),
                  ChartWidget(chartData2, exactMarksData2[0]['sem'], batchIdx),
                  SizedBox(
                    height: 30,
                  ),
                  ChartWidget(chartData3, exactMarksData3[0]['sem'], batchIdx),
                  SizedBox(
                    height: 30,
                  ),
                  ChartWidget(chartData4, exactMarksData4[0]['sem'], batchIdx),
                  SizedBox(
                    height: 30,
                  ),
                  ChartWidget(chartData5, exactMarksData5[0]['sem'], batchIdx),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
