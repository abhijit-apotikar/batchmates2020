import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../class/colorCodeNotifier.dart';

import '../services/authService.dart';
import '../widgets/loadingWidget.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final AuthService _authService = new AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    return loading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: localColorCode.ccBackgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    splashColor: Colors.grey,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/SignIn');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Container(
                        width: size.width * 0.7,
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
                                'Log in or Register',
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
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _authService.signInWithGoogle();

                      if (result == null) {
                        print('Error siging in');
                        setState(() {
                          loading = false;
                        });
                      } else {
                        print('Signed In');
                        print(result);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Container(
                        width: size.width * 0.7,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                                image:
                                    AssetImage("assets/images/google_logo.png"),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 0.0,
                    ),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Made with ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontFamily: 'Nunito'),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24,
                      ),
                      Text(
                        ' by Abhijit',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontFamily: 'Nunito'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'gradbatch2020',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepOrangeAccent,
                            fontFamily: 'Nunito'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'version 1.0',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepOrangeAccent,
                            fontFamily: 'Nunito'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
