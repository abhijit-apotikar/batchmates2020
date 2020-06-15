import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../class/colorCodeNotifier.dart';

import '../services/authService.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    return Scaffold(
      backgroundColor: localColorCode.ccBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: InkWell(
                  onTap: () async {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        size: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with e-mail',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: InkWell(
                  onTap: () async {
                    dynamic result = await _authService.signInWithGoogle();
                    if (result == null) {
                      print('Error siging in');
                    } else {
                      print('Signed In');
                      print(result);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage("assets/images/google_logo.png"),
                          height: 35.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nunito',
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            /*FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await _authService.signInWithGoogle();
                    if (result == null) {
                      print('Error siging in');
                    } else {
                      print('Signed In');
                      print(result);
                    }
                  },
                  icon: 
                  Image(),/*Icon(
                    Ionicons.logo_google,
                  )*/,
                  label: Text(
                    'Google Sign In',
                    style: TextStyle(fontSize: 28),
                  )),*/
          ],
        ),
      ),
    );
  }
}
