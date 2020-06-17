import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../class/colorCodeNotifier.dart';
import '../class/actualColorCodes.dart';
import '../class/arguments.dart';
import '../class/argumentsDetail.dart';

import '../data/mainData.dart';
import '../services/authService.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();

    final user = Provider.of<FirebaseUser>(context);
    final AuthService _authService = new AuthService();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: localColorCode.ccBackgroundColor,
      appBar: AppBar(
        title: new Text(
          'Batch of 2020',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: localColorCode.ccAppBarForegroundColor,
          ),
        ),
        iconTheme: new IconThemeData(
          color: localColorCode.ccAppBarForegroundColor,
          size: 28,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              size: 28,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/SearchWidget');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: (size.height) * 0.25,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    gradient: new LinearGradient(
                        colors: [
                          Colors.cyan,
                          Colors.pink,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Daily Quote',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Pica',
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: new StreamBuilder(
                            stream: Firestore.instance
                                .collection('quotes')
                                .document('quote')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: new CircularProgressIndicator(),
                                );
                              }
                              var quote = snapshot.data;
                              return new Column(
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('${quote['quote']}',
                                              style: TextStyle(
                                                fontFamily: 'Satisfy',
                                                fontSize: 20,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ]),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        ': ${quote['author']}',
                                        style: TextStyle(
                                          fontFamily: 'Satisfy',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'updated: ${quote['updated']}',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: (size.height) * 0.95,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(7, (index) {
                        return InkWell(
                          child: Container(
                           
                            child: Card(
                              elevation: 3,
                              color: (index == 0 || index == 3 || index == 4)
                                  ? localColorCode.ccGridColor1
                                  : localColorCode.ccGridColor2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color:
                                      (index == 0 || index == 3 || index == 4)
                                          ? localColorCode.ccGridBorderColor1
                                          : localColorCode.ccGridBorderColor2,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'M${index + 1}',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        (index == 0 || index == 3 || index == 4)
                                            ? localColorCode.ccGridTitleColor1
                                            : localColorCode.ccGridTitleColor2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Arguments idx = new Arguments(index);
                            Navigator.pushNamed(
                              context,
                              '/StudentList',
                              arguments: idx,
                            );
                          },
                        );
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/DeveloperInfo',
                      );
                    },
                    child: Hero(
                      tag: 'Developer',
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: localColorCode.ccAppBarForegroundColor,
                            ),
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: user.photoUrl == null
                                  ? AssetImage("assets/images/person.png")
                                  : NetworkImage('${user.photoUrl}'),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  user.displayName == null
                      ? SizedBox(
                          height: 10.0,
                        )
                      : Text(
                          '${user.displayName}',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: localColorCode.ccAppBarForegroundColor,
                          ),
                        ),
                  Text(
                    '${user.email}',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: localColorCode.ccAppBarForegroundColor,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: localColorCodeNotifier.getColorCode() == ccLight
                          ? false
                          : true,
                      onChanged: (_) {
                        if (localColorCodeNotifier.getColorCode() == ccLight) {
                          localColorCodeNotifier.setColorCode(ccDark);
                        } else if (localColorCodeNotifier.getColorCode() ==
                            ccDark) {
                          localColorCodeNotifier.setColorCode(ccLight);
                        }
                      },
                    )
                  ]),
            ),
            ListTile(
              title: InkWell(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    await _authService.signOutFromGoogle();
                  } //showAlertDialog(context),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/*showAlertDialog(BuildContext context) {
  final user = Provider.of<FirebaseUser>(context);
    final AuthService _authService = new AuthService();
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text('Yes'),
    onPressed: () {
      _authService.signOutFromGoogle();
      // Navigator.pushNamed(context, '/LogInPage');
    },
  );
  Widget continueButton = FlatButton(
    child: Text('No'),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Do you really want to Log Out?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}*/

class DataSearch extends SearchDelegate {
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
      return student['fname'].toLowerCase().startsWith(query.toLowerCase()) ||
          student['lname'].toLowerCase().startsWith(query.toLowerCase()) ||
          '${student['fname'].toLowerCase()} ${student['lname'].toLowerCase()}'
              .startsWith(query.toLowerCase()) ||
          '${student['fname'].toLowerCase()} ${student['lname'].toLowerCase()}'
              .startsWith(query.toLowerCase());
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
                        color: localColorCode.ccAppBarForegroundColor,
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
