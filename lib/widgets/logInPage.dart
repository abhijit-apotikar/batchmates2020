import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../services/authService.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  dynamic result = await _authService.signInWithGoogle();
                  if (result == null) {
                    print('Error siging in');
                  } else {
                    print('Signed In');
                    print(result);
                  }
                },
                icon: Icon(
                  Ionicons.logo_google,
                ),
                label: Text(
                  'Google Sign In',
                  style: TextStyle(fontSize: 28),
                )),
          ],
        ),
      ),
    );
  }
}
