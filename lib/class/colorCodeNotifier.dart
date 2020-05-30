import 'package:flutter/material.dart';
import './colorCode.dart';

class ColorCodeNotifier with ChangeNotifier {
  ColorCode _colorCode;
  ColorCodeNotifier(this._colorCode);
  getColorCode() => _colorCode;
  setColorCode(ColorCode colorCode) async {
    _colorCode = colorCode;
    notifyListeners();
  }
}
