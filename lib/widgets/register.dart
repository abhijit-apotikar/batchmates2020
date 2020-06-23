import 'package:flutter/material.dart';
import 'package:gradbatch2020/services/authService.dart';
import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';

import '../widgets/alertDialog.dart';
import '../widgets/loadingWidget.dart';

import '../shared.dart/constants.dart';

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
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
                'Register',
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
                  elevation: 4,
                  color: Colors.pink,
                  child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: Text(
                        'sign in',
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
                      style: myTextFormFieldTextStyle,
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
                      style: myTextFormFieldTextStyle,
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
                                .registerWithEmailAndPassword(email, password);
                            if (result != null) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please enter a valid email id';
                                showAlertDialog(context, error);
                              });
                            }
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                    /* SizedBox(
                height: 20,
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
                  ],
                ),
              ),
            ),
          );
  }
}
