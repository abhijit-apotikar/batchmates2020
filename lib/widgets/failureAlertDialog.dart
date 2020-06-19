import 'package:flutter/material.dart';

showFailureAlertDialog(BuildContext context, String msg) {
  // set up the buttons
  Widget okButton = OutlineButton(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Text(
      'OK',
      style: TextStyle(
        color: Colors.green,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.mood_bad,
          size: 50,
          color: Colors.red,
        ),
      ],
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Text(
            msg,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
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
