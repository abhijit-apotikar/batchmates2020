import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String msg) {
  // set up the buttons
  Widget okButton = FlatButton(
    child: Text('Ok'),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Alert Dialog'),
    content: Text(msg),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
