import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../class/LogInDetail.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    LogInDetail lid = new LogInDetail(googleSignIn,user);
    Navigator.pushNamed(context, '/', arguments: lid);
    return user;
  }

  /*void _signOut(BuildContext context) {
    googleSignIn.signOut();
    Navigator.pushNamed(context, '/LogInPage');
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Card(
                elevation: 6,
                child: Container(
                  width: size.width * 0.8,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Google Sign In',
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ),
              onTap: () {
                _signIn(context);
              },
            ),
            SizedBox(
              height: 30,
            ),
            /*InkWell(
              child: Card(
                elevation: 6,
                child: Container(
                  width: size.width * 0.8,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Google Sign In',
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ),
              onTap: () => _signOut(context),
            ),*/
          ],
        ),
      ),
    );
  }
}
