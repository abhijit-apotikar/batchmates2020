import 'package:flutter/material.dart';
import '../widgets/loadingWidget.dart';

showAdvLoadingDialog(BuildContext context) {
  // set up the buttons

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Loading...'),
      ],
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadingWidget(),
      ],
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
