import 'package:flutter/material.dart';
import 'package:gradbatch2020/class/marksDataObj.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../class/argumentsForDetailInfo.dart';
import '../class/colorCodeNotifier.dart';
import '../services/serviceToChartData.dart';

final backgroundColor = Colors.white;
final appBarForeground = Colors.deepOrangeAccent;
final appBarBackground = Colors.white;
final appBarArea = Colors.white;

class DetailInfo extends StatefulWidget {
  @override
  _DetailInfoState createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  String dropdownValue = 'bscSem1W2017';
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    RouteSettings settings = ModalRoute.of(context).settings;
    ArgumentsForDetailInfo nameInfo = settings.arguments;

    final Size size = MediaQuery.of(context).size;

    final data = nameInfo.data;

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
          '${data['fName']} ${data['lName']}',
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
                            '${data['batch']}'.toUpperCase(),
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
              padding: const EdgeInsets.all(5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(width: 20,),
                    Text(
                      'Semester:',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
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
                        });
                      },
                      items: <String>[
                        'bscSem1W2017',
                        'bscSem2S2018',
                        'bscSem3W2018',
                        'bscSem4S2019',
                        'bscSem5W2019'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              height: size.height * 0.67,
              width: size.width,
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection(dropdownValue)
                    .where('$dropdownValue' + '_fName',
                        isEqualTo: data['fName'])
                    .where('$dropdownValue' + '_lName',
                        isEqualTo: data['lName'])
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data.documents.length == 0) {
                    return Center(
                        child: new Text(
                      'No record found',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: localColorCode.ccListTileSubTitle,
                      ),
                    ));
                  }
                  if (snapshot.hasError)
                    return Center(
                        child: new Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: localColorCode.ccListTileSubTitle,
                      ),
                    ));
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: new CircularProgressIndicator(),
                      );

                    default:
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data =
                                snapshot.data.documents[index];
                            print(data.data.containsKey('stat'));
                            var chartData =
                                new ServiceToChartData().giveMarks(data);
                            return Container(
                              height: size.height * 0.65,
                              width: size.width,
                              child: SfCartesianChart(
                                enableSideBySideSeriesPlacement: false,
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(text: 'Subjects'),
                                ),
                                primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  title: AxisTitle(text: 'marks'),
                                  interval: 5,
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                  overflowMode: LegendItemOverflowMode.wrap,
                                  title: LegendTitle(
                                      text: dropdownValue,
                                      textStyle: ChartTextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w900)),
                                ),
                                tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                  // format: 'series.name',
                                ),
                                series: <ChartSeries<MarksDataObj, String>>[
                                  ColumnSeries<MarksDataObj, String>(
                                    name: 'OutOf100/75',
                                    // opacity: 0.9,
                                    // width: 0.4,
                                    color: Colors.amber,
                                    dataSource: chartData,
                                    xValueMapper: (MarksDataObj sales, _) =>
                                        sales.sub,
                                    yValueMapper: (MarksDataObj sales, _) =>
                                        (sales.iPlusT),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      //  labelAlignment: ChartDataLabelAlignment.middle,
                                    ),
                                  ),
                                  ColumnSeries<MarksDataObj, String>(
                                    name: 'Theory',
                                    width: 0.7,
                                    color: Colors.deepOrangeAccent,
                                    dataSource: chartData,
                                    xValueMapper: (MarksDataObj sales, _) =>
                                        sales.sub,
                                    yValueMapper: (MarksDataObj sales, _) =>
                                        sales.tMarks,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                  ColumnSeries<MarksDataObj, String>(
                                    name: 'Practical',
                                    opacity: 0.9,
                                    width: 0.5,
                                    color: Colors.cyan,
                                    dataSource: chartData,
                                    xValueMapper: (MarksDataObj sales, _) =>
                                        sales.sub,
                                    yValueMapper: (MarksDataObj sales, _) =>
                                        sales.pract,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      labelAlignment:
                                          ChartDataLabelAlignment.top,
                                    ),
                                  ),
                                  ColumnSeries<MarksDataObj, String>(
                                    name: 'Internal',
                                    opacity: 1,
                                    width: 0.3,
                                    color: Colors.greenAccent,
                                    dataSource: chartData,
                                    xValueMapper: (MarksDataObj sales, _) =>
                                        sales.sub,
                                    yValueMapper: (MarksDataObj sales, _) =>
                                        sales.internal,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      labelAlignment:
                                          ChartDataLabelAlignment.outer,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    /*ListView.builder(
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot data =
                                          snapshot.data.documents[index];
                                      print(data.data.containsKey('stat'));
                                      var chartData = new ServiceToChartData()
                                          .giveMarks(data);
                                      return Container(
                                        height: size.height * 0.65,
                                        width: size.width,
                                        child: SfCartesianChart(
                                          enableSideBySideSeriesPlacement: false,
                                          primaryXAxis: CategoryAxis(
                                            title: AxisTitle(text: 'Subjects'),
                                          ),
                                          primaryYAxis: NumericAxis(
                                            minimum: 0,
                                            maximum: 100,
                                            title: AxisTitle(text: 'marks'),
                                            interval: 5,
                                          ),
                                          legend: Legend(
                                            isVisible: true,
                                            position: LegendPosition.bottom,
                                            overflowMode:
                                                LegendItemOverflowMode.wrap,
                                            title: LegendTitle(
                                                text: dropdownValue,
                                                textStyle: ChartTextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w900)),
                                          ),
                                          tooltipBehavior: TooltipBehavior(
                                            enable: true,
                                            // format: 'series.name',
                                          ),
                                          series: <
                                              ChartSeries<MarksDataObj, String>>[
                                            ColumnSeries<MarksDataObj, String>(
                                              name: 'OutOf100/75',
                                              // opacity: 0.9,
                                              // width: 0.4,
                                              color: Colors.amber,
                                              dataSource: chartData,
                                              xValueMapper:
                                                  (MarksDataObj sales, _) =>
                                                      sales.sub,
                                              yValueMapper: (MarksDataObj sales,
                                                      _) =>
                                                  (sales.tMarks + sales.internal),
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                isVisible: true,
                                                //  labelAlignment: ChartDataLabelAlignment.middle,
                                              ),
                                            ),
                                            /*  ColumnSeries<MarksData, String>(
                                              name: '${examName[sem - 1]}',
                                              width: 0.7,
                                              color: Colors.deepOrangeAccent,
                                              dataSource: chartData,
                                              xValueMapper: (MarksData sales, _) =>
                                                  sales.sub,
                                              yValueMapper: (MarksData sales, _) =>
                                                  sales.tMarks,
                                              dataLabelSettings: DataLabelSettings(
                                                isVisible: true,
                                              ),
                                            ),
                                            ColumnSeries<MarksData, String>(
                                              name: 'Practical',
                                              opacity: 0.9,
                                              width: 0.5,
                                              color: Colors.cyan,
                                              dataSource: chartData,
                                              xValueMapper: (MarksData sales, _) =>
                                                  sales.sub,
                                              yValueMapper: (MarksData sales, _) =>
                                                  sales.pract,
                                              dataLabelSettings: DataLabelSettings(
                                                isVisible: true,
                                                labelAlignment:
                                                    ChartDataLabelAlignment.top,
                                              ),
                                            ),
                                            ColumnSeries<MarksData, String>(
                                              name: 'Internal',
                                              opacity: 1,
                                              width: 0.3,
                                              color: Colors.deepPurpleAccent,
                                              dataSource: chartData,
                                              xValueMapper: (MarksData sales, _) =>
                                                  sales.sub,
                                              yValueMapper: (MarksData sales, _) =>
                                                  sales.internal,
                                              dataLabelSettings: DataLabelSettings(
                                                isVisible: true,
                                                labelAlignment:
                                                    ChartDataLabelAlignment.middle,
                                              ),
                                            ),*/
                                          ],
                                        ),
                                      );
                                      // var doc = snapshot.data.documents;
                                    });*/
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
