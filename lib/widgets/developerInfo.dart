import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';

class DeveloperInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();

    final user = Provider.of<FirebaseUser>(context);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: localColorCode.ccBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: localColorCode.ccAppBarForegroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text(
          'USER',
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
            Hero(
              tag: 'Developer',
              child: Container(
                height: size.height * 0.4,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: user.photoUrl == null
                        ? AssetImage("assets/images/person.png")
                        : new NetworkImage(user.photoUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Name: ',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          user.displayName == null
                              ? 'No display name associated with current email id'
                              : user.displayName,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Email: ',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          user.email,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
