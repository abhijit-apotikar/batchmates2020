import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../class/colorCodeNotifier.dart';

import '../class/searchArguments.dart';

import '../class/argumentsForDetailInfo.dart';

import './loadingWidget.dart';

class SearchResultsWidget extends StatelessWidget {
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
    SearchArguments sa = settings.arguments;

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
          'Search Results',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: localColorCode.ccAppBarForegroundColor,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          
          Scrollbar(
            child: Container(
              color: localColorCode.ccBackgroundColor,
              width: double.infinity,
              height: (size.height) * 0.87,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('students')
                      .where('batch', isEqualTo: '${sa.batch}'.toLowerCase())
                      .where('fName', isEqualTo: '${sa.fName}'.toLowerCase())
                      .where('lName', isEqualTo: '${sa.lName}'.toLowerCase())
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: Text(
                          'No record found',
                          style: TextStyle(
                              color: localColorCode.ccAppBarForegroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Nunito'),
                        ),
                      );
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
