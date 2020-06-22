import 'package:flutter/material.dart';

showOwnAboutDialog(BuildContext context, Size size) {
  // set up the buttons
  Widget closeButton = OutlineButton(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Text(
      'Close',
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
        Text('About',style: TextStyle(fontWeight: FontWeight.bold),),
      ],
    ),
    content: Container(
      height: size.height * 0.2,
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          Text('Developer: '),
          Text('Abhijit Apotikar'),
        ]),
        SizedBox(
          height: 20,
        ),
        Row(children: <Widget>[
          Text('Email: '),
          Text('qadfaplays@gmail.com'),
        ]),
        SizedBox(
          height: 20,
        ),
        Row(children: <Widget>[
          Text('version: '),
          Text('v1.0.0'),
        ]),
      ]),
    ),
    actions: [
      closeButton,
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
