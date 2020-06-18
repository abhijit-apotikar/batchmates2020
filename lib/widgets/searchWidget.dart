import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../class/colorCodeNotifier.dart';

import '../widgets/loadingWidget.dart';

import '../class/searchArguments.dart';

import '../shared.dart/constants.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  ///------------textField e-mail,password local variables--------
  String fName = '';
  String lName = '';
  String batch = '';
  String error = '';

  final fNameCtrl = TextEditingController();
  final lNameCtrl = TextEditingController();
  final batchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();

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
                'Search',
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
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
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
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                       
                        decoration: textFormFieldDecoration.copyWith(
                            hintText: 'first name'),
                        controller: fNameCtrl,
                        validator: (val) =>
                            val.isEmpty ? 'Enter first name' : null,
                        onChanged: (val) {
                          setState(() {
                            fName = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textFormFieldDecoration.copyWith(
                            hintText: 'last name'),
                        controller: lNameCtrl,
                        validator: (val) =>
                            val.isEmpty ? 'Enter last name' : null,
                        onChanged: (val) {
                          lName = val;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            textFormFieldDecoration.copyWith(hintText: 'batch'),
                        controller: batchCtrl,
                        validator: (val) =>
                            val.isEmpty ? 'Enter last name' : null,
                        onChanged: (val) {
                          batch = val;
                        },
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            elevation: 5,
                            color: Colors.amber[300],
                            child: FlatButton(
                              onPressed: () {
                                fNameCtrl.clear();
                                lNameCtrl.clear();
                                batchCtrl.clear();
                              },
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Material(
                            elevation: 5,
                            color: Colors.amber[300],
                            child: FlatButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  SearchArguments sa =
                                      new SearchArguments(fName, lName, batch);
                                  print(fName);
                                  Navigator.pushNamed(context, '/SearchResults',
                                      arguments: sa);
                                }
                              },
                              child: Text(
                                'Search',
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
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
