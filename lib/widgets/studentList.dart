import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../class/colorCodeNotifier.dart';
import '../class/arguments.dart';
import '../class/argumentsDetail.dart';
import '../class/argumentDetailsOther.dart';
import '../data/mainData.dart';

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
              showSearch(
                  context: context, delegate: DataSearch(mainIndex.aridx));
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: (size.height) * 0.13,
            width: double.infinity,
            color: localColorCode.ccBackgroundColor,
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
                    return Center(child: new CircularProgressIndicator());
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
                          child: new CircularProgressIndicator(),
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
                                    data['fName'] + ' ' + data['lName'],
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
                                    ArgumentDetailsOther idx = new ArgumentDetailsOther(
                                        data['fName'], data['lName'], index,data);
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

class DataSearch extends SearchDelegate {
  final int batchToSearch;
  DataSearch(this.batchToSearch);

  var suggestions = [
    {'fname': 'Suhas', 'lname': 'Upase', 'batch': 'M2', 'gender': 'Male'},
    {'fname': 'Ritesh', 'lname': 'Sonone', 'batch': 'M2', 'gender': 'Male'},
    {'fname': 'Aniket', 'lname': 'Donode', 'batch': 'M2', 'gender': 'Male'},
    {'fname': 'Swapnil', 'lname': 'Shelke', 'batch': 'M2', 'gender': 'Male'},
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.orangeAccent,
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: localColorCode.ccPrimaryColor,
      ),
      primaryColorBrightness: localColorCode.ccBrightness,
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();

    final resultSugg = mainData.where((student) {
      return (student['fname'].toLowerCase().startsWith(query.toLowerCase()) ||
              student['lname'].toLowerCase().startsWith(query.toLowerCase()) ||
              '${student['fname'].toLowerCase()} ${student['lname'].toLowerCase()}'
                  .startsWith(query.toLowerCase()) ||
              '${student['fname'].toLowerCase()} ${student['lname'].toLowerCase()}'
                  .startsWith(query.toLowerCase())) &&
          (student['batch'] == ('M${batchToSearch + 1}'));
    }).toList();

    String giveResultFront(int idx) {
      if (resultSugg[idx]['fname']
          .toLowerCase()
          .startsWith(query.toLowerCase())) {
        return resultSugg[idx]['fname'] + ' ' + resultSugg[idx]['lname'];
      } else {
        return resultSugg[idx]['lname'] + ' ' + resultSugg[idx]['fname'];
      }
    }

    return query.isNotEmpty &&
            (mainData.where((student) {
              return student['fname']
                      .toLowerCase()
                      .startsWith(query.toLowerCase()) ||
                  student['lname']
                      .toLowerCase()
                      .startsWith(query.toLowerCase()) ||
                  '${student['fname'].toLowerCase()} ${student['lname'].toLowerCase()}'
                      .startsWith(query.toLowerCase()) ||
                  '${student['fname'].toLowerCase()} ${student['lname'].toLowerCase()}'
                      .startsWith(query.toLowerCase());
            }).toList())
                .isEmpty
        ? ListTile(
            title: RichText(
              text: TextSpan(
                text: 'No record found for ',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: localColorCode.ccAppBarForegroundColor,
                ),
                children: [
                  TextSpan(
                    text: '\"$query\"',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          )
        : query.isEmpty
            ? Center(
                child: Container(
                  child: Text(
                    'Please enter some name to search...',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Nunito'),
                  ),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.person),
                  trailing: resultSugg[index]['gender'] == 'Female'
                      ? Icon(
                          Ionicons.md_female,
                          color: Colors.pink,
                        )
                      : Icon(
                          Ionicons.md_male,
                          color: Colors.blue,
                        ),
                  title: RichText(
                    text: TextSpan(
                      text: giveResultFront(index).substring(0, query.length),
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Nunito'),
                      children: [
                        TextSpan(
                          text: giveResultFront(index).substring(query.length),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontFamily: 'Nunito'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    ArgumentsDetail idx = new ArgumentsDetail(
                        resultSugg[index]['fname'],
                        resultSugg[index]['lname'],
                        index);
                    Navigator.pushNamed(
                      context,
                      '/DetailInfo',
                      arguments: idx,
                    );
                  },
                  subtitle: Text(
                    resultSugg[index]['batch'],
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                itemCount: resultSugg.length,
              );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();

    final suggestionList = query.isEmpty
        ? suggestions
        : mainData.where((student) {
            return (student['fname']
                        .toLowerCase()
                        .startsWith(query.toLowerCase()) ||
                    student['lname']
                        .toLowerCase()
                        .startsWith(query.toLowerCase()) ||
                    '${student['fname'].toLowerCase()} ${student['lname'].toLowerCase()}'
                        .toLowerCase()
                        .startsWith(query.toLowerCase()) ||
                    '${student['lname'].toLowerCase()} ${student['fname'].toLowerCase()}'
                        .toLowerCase()
                        .startsWith(query.toLowerCase())) &&
                (student['batch'] == ('M${batchToSearch + 1}'));
          }).toList();

    String giveRightFront(int idx) {
      if (suggestionList[idx]['fname']
          .toLowerCase()
          .startsWith(query.toLowerCase())) {
        return suggestionList[idx]['fname'] +
            ' ' +
            suggestionList[idx]['lname'];
      } else {
        return suggestionList[idx]['lname'] +
            ' ' +
            suggestionList[idx]['fname'];
      }
    }

    return query.isNotEmpty &&
            (mainData.where((student) {
              return student['fname']
                      .toLowerCase()
                      .startsWith(query.toLowerCase()) ||
                  student['lname']
                      .toLowerCase()
                      .startsWith(query.toLowerCase()) ||
                  '${student['fname'].toLowerCase()} ${student['lname'].toLowerCase()}'
                      .toLowerCase()
                      .startsWith(query.toLowerCase()) ||
                  '${student['lname'].toLowerCase()} ${student['fname'].toLowerCase()}'
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
            }).toList())
                .isEmpty
        ? ListTile(
            title: RichText(
              text: TextSpan(
                text: 'No suggestions for ',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: localColorCode.ccPrimaryColor,
                ),
                children: [
                  TextSpan(
                    text: '\"$query\"',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.person),
              trailing: suggestionList[index]['gender'] == 'Female'
                  ? Icon(
                      Ionicons.md_female,
                      color: Colors.pink,
                    )
                  : Icon(
                      Ionicons.md_male,
                      color: Colors.blue,
                    ),
              subtitle: Text(
                suggestionList[index]['batch'],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: giveRightFront(index).substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Nunito'),
                  children: [
                    TextSpan(
                      text: giveRightFront(index).substring(query.length),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontFamily: 'Nunito'),
                    ),
                  ],
                ),
              ),
              onTap: () {
                ArgumentsDetail idx = new ArgumentsDetail(
                    suggestionList[index]['fname'],
                    suggestionList[index]['lname'],
                    index);
                Navigator.pushNamed(
                  context,
                  '/DetailInfo',
                  arguments: idx,
                );
              },
            ),
            itemCount: suggestionList.length,
          );
  }
}
