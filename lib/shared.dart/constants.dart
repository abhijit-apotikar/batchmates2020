import 'package:flutter/material.dart';

const textFormFieldDecoration = InputDecoration(
  //fillColor: Theme.of(context=)
 // filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blue,
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2,
    ),
  ),
);
