import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradbatch2020/widgets/logInPage.dart';
import 'package:gradbatch2020/widgets/myHomePage.dart';
import 'package:provider/provider.dart';

class MainWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return LogInPage();
    } else {
      return MyHomePage();
    }
  }
}
