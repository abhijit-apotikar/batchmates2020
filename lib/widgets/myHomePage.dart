import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradbatch2020/widgets/failureAlertDialog.dart';
import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';
import '../class/actualColorCodes.dart';
import '../class/arguments.dart';

import '../widgets/about.dart';

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

//     Timestamp t = document['timeFieldName'];
// DateTime d = t.toDate();
// print(d.toString());

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
        child: Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(colors: [
              localColorCode.mainBackgroundGradient1,
              localColorCode.mainBackgroundGradient2,
              localColorCode.mainBackgroundGradient3,
            ], stops: [
              0.0,
              0.5,
              1.0
            ], tileMode: TileMode.clamp),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      height: (size.height) * 0.30,
                      margin: const EdgeInsets.all(10.0),
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: localColorCode.quoteCardBorder, width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        gradient: new LinearGradient(
                            colors: [
                              localColorCode.backgroundGradient1,
                              localColorCode.backgroundGradient2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // begin: const FractionalOffset(0.0, 0.0),
                            // end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
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
                            Timestamp t = quote['updated'];
                            DateTime d = t.toDate().toLocal();
                            return new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text('Daily Quote',
                                            style: TextStyle(
                                              fontFamily: 'Satisfy',
                                              fontSize: 24,
                                              color:
                                                  localColorCode.quoteCardText,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text('${quote['quote']}',
                                            style: TextStyle(
                                              fontFamily: 'Satisfy',
                                              fontSize: 20,
                                              color:
                                                  localColorCode.quoteCardText,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      ': ${quote['author']}',
                                      style: TextStyle(
                                        fontFamily: 'Satisfy',
                                        color: localColorCode.quoteCardText,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'updated: ${d.toString()}',
                                      style: TextStyle(
                                          fontSize: 10, fontFamily: 'Satisfy'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          })),
                  Container(
                    width: double.infinity,
                    height: (size.height) * 1.0,
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
                                      color: (index == 0 ||
                                              index == 3 ||
                                              index == 4)
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
            new Divider(
              height: 0.0,
              color: Colors.grey,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              enabled:
                  user.email == 'abhijit.apotikar156@gmail.com' ? true : false,
              title: InkWell(
                  child: Text(
                    'Edit Records',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    if(user.email == 'abhijit.apotikar156@gmail.com'){       ////Try bt let me tell U it won't work!!!
                       Navigator.pushNamed(context, '/EditRecord');
                    }else {
                      showFailureAlertDialog(context, 'Access Denied');
                    }
                   
                  }),
              subtitle: Text(
                user.email == 'abhijit.apotikar156@gmail.com'              
                    ? 'Congrats You have required Admin Priviledges to edit records'
                    : 'Sorry, edit option disabled as you lack Admin Priviledges',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: user.email == 'abhijit.apotikar156@gmail.com'
                      ? Colors.green
                      : Colors.red,
                  fontSize: 14,
                ),
              ),
            ),
            new Divider(
              height: 0.0,
              color: Colors.grey,
              thickness: 2,
              indent: 20,
              endIndent: 20,
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
                  }),
            ),
            new Divider(
              height: 0.0,
              color: Colors.grey,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              title: InkWell(
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    showOwnAboutDialog(context, size);
                  }),
            ),
            new Divider(
              height: 0.0,
              color: Colors.grey,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}
