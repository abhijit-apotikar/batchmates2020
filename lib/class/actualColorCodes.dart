import 'package:flutter/material.dart';

import './colorCode.dart';

final ccLight = new ColorCode(
  ccAppBarColor: Colors.white,
  ccPrimarySwatch: Colors.lightGreen,
  ccPrimaryColor: Colors.black,
  ccAppBarForegroundColor: Colors.deepOrangeAccent,
  ccBackgroundColor: Colors.white,
  ccGridColor1: Colors.amberAccent,
  ccGridColor2: Colors.indigoAccent,
  ccGridBorderColor1: Colors.amberAccent,
  ccGridBorderColor2: Colors.indigoAccent,
  ccGridTitleColor1: Colors.indigoAccent,
  ccGridTitleColor2: Colors.amberAccent,
  ccBatchDetailsForegroundColor: Colors.indigoAccent,
  ccMale: Colors.blue,
  ccFemale: Colors.pink,
  ccListTileTitle: Colors.black,
  ccListTileSubTitle: Colors.grey,
  ccListTileBackground: Colors.white,
  loadingBackground: Colors.white,
  loadingForeground: Colors.yellow,
  ccBrightness: Brightness.light,
);

final ccDark = new ColorCode(
  ccAppBarColor: Colors.pink,
  ccPrimarySwatch: Colors.grey,
  ccPrimaryColor: Colors.white,
  ccAppBarForegroundColor: Colors.green,
  ccBackgroundColor: Colors.grey[850],
  ccGridColor1: Colors.amberAccent,
  ccGridColor2: Colors.indigoAccent,
  ccGridBorderColor1: Colors.redAccent,
  ccGridBorderColor2: Colors.redAccent,
  ccGridTitleColor1: Colors.green,
  ccGridTitleColor2: Colors.green,
  ccBatchDetailsForegroundColor: Colors.green,
  ccMale: Colors.blue,
  ccFemale: Colors.pink,
  ccListTileTitle: Colors.green,
  ccListTileSubTitle: Colors.green,
  ccListTileBackground: Colors.black,
  loadingBackground: Colors.grey[850],
  loadingForeground: Colors.green,
  ccBrightness: Brightness.dark,
);
