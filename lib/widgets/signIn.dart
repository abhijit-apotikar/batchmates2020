import 'package:flutter/material.dart';
import 'package:gradbatch2020/services/authService.dart';
import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';

import '../widgets/loadingWidget.dart';
import '../widgets/alertDialog.dart';

import '../shared.dart/constants.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  ///------------textField e-mail,password local variables--------
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    AuthService _auth = new AuthService();
    return loading
        ? LoadingWidget()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: new Text(
                'Log in',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: localColorCode.ccAppBarForegroundColor,
                ),
              ),
              iconTheme: new IconThemeData(
                color: localColorCode.ccAppBarForegroundColor,
                size: 20,
              ),
              actions: <Widget>[
                Material(
                  color: Colors.pink,
                  elevation: 4,
                  child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Register');
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Register',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          textFormFieldDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val.isEmpty ? 'Enter an e-mail' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textFormFieldDecoration.copyWith(
                          hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Password should be atleast 6 characters long'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(height: 30),
                    Material(
                      elevation: 5,
                      color: Colors.amber[300],
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);

                            if (result != null) {
                              Navigator.pop(context);
                            }
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Wrong credentials, try again';
                                showAlertDialog(context, error);
                              });
                            }
                          }
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
