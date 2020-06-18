import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../class/colorCodeNotifier.dart';
import '../class/arguments.dart';

import '../class/argumentsForDetailInfo.dart';

import './loadingWidget.dart';

class StudentList extends StatelessWidget {
  final backgroundColor = Colors.white;
  final appBarForeground = Colors.deepOrangeAccent;
  final appBarBackground = Colors.white;
  final appBarArea = Colors.white;

  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();

    final size = MediaQuery.of(context).size;

    RouteSettings settings = ModalRoute.of(context).settings;
    Arguments mainIndex = settings.arguments;

    return Scaffold(
      backgroundColor: localColorCode.ccBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: new IconThemeData(
          color: localColorCode.ccAppBarForegroundColor,
          size: 28,
        ),
        title: new Text(
          'M${mainIndex.aridx + 1}',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: localColorCode.ccAppBarForegroundColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 28,
            onPressed: () {
              Navigator.pushNamed(context, '/SearchWidget');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: (size.height) * 0.13,
            width: double.infinity,
            //color: localColorCode.ccBackgroundColor,
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('batches')
                    .document('m${mainIndex.aridx + 1}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: new CircularProgressIndicator(),
                    );
                  }
                  var batchDocument = snapshot.data;
                  return new Card(
                    color: localColorCode.ccBackgroundColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.redAccent,
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Batch Strength : ${batchDocument['strength']} ',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: localColorCode
                                        .ccBatchDetailsForegroundColor,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Ionicons.md_female,
                                        size: 18,
                                        color: localColorCode.ccFemale,
                                      ),
                                      Text(
                                        '${batchDocument['girls']} ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          color: localColorCode.ccFemale,
                                        ),
                                      ),
                                      Icon(
                                        Ionicons.md_male,
                                        size: 18,
                                        color: localColorCode.ccMale,
                                      ),
                                      Text(
                                        '${batchDocument['boys']}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          color: localColorCode.ccMale,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Subject Combination : ${batchDocument['subComb']}',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: localColorCode
                                    .ccBatchDetailsForegroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Scrollbar(
            child: Container(
              color: localColorCode.ccBackgroundColor,
              width: double.infinity,
              height: (size.height) * 0.74,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('students')
                      .where('batch', isEqualTo: 'm${mainIndex.aridx + 1}')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          child: new LoadingWidget(),
                        );
                      default:
                        return new ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data =
                                  snapshot.data.documents[index];
                              return Card(
                                color: localColorCode.ccListTileBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: index % 2 == 0
                                        ? Colors.deepPurpleAccent
                                        : Colors.amberAccent,
                                    width: 1.0,
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage:
                                          (data['gender'] == 'male')
                                              ? AssetImage(
                                                  'assets/images/sbman.png')
                                              : AssetImage(
                                                  'assets/images/woman.png')),
                                  title: Text(
                                    '${data['fName'][0].toUpperCase()}' +
                                        '${data['fName'].substring(1)}' +
                                        ' ' +
                                        '${data['lName'][0].toUpperCase()}' +
                                        '${data['lName'].substring(1)}',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      color: localColorCode.ccListTileTitle,
                                    ),
                                  ),
                                  subtitle: Text(
                                    data['batch'].toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      color: localColorCode.ccListTileSubTitle,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.more_vert,
                                    color: localColorCode.ccListTileTitle,
                                  ),
                                  onTap: () {
                                    ArgumentsForDetailInfo idx =
                                        new ArgumentsForDetailInfo(
                                            data, data['fName'], data['lName']);
                                    Navigator.pushNamed(
                                      context,
                                      '/DetailInfo',
                                      arguments: idx,
                                    );
                                  },
                                ),
                              );
                            });
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
