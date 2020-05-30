import 'package:flutter/material.dart';
import 'package:gradbatch2020/widgets/developerInfo.dart';
import 'package:gradbatch2020/widgets/studentList.dart';
import 'package:provider/provider.dart';
//import 'package:syncfusion_flutter_core/core.dart';

import './class/colorCodeNotifier.dart';
import './class/actualColorCodes.dart';

import './widgets/myHomePage.dart';
import './widgets/developerInfo.dart';
import './widgets/detailInfo.dart';

void main() {
  
  runApp(
    ChangeNotifierProvider<ColorCodeNotifier>(
      create: (_) => ColorCodeNotifier(ccLight),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localColorCodeNotifier = Provider.of<ColorCodeNotifier>(context);
    final localColorCode = localColorCodeNotifier.getColorCode();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Info. App',
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
              body: MyHomePage(),
            ),
        '/DeveloperInfo':(context)=> Scaffold(
          body: DeveloperInfo(),
        ),
        '/StudentList':(context)=> Scaffold(
          body: StudentList(),
        ),
        '/DetailInfo':(context)=> Scaffold(
          body: DetailInfo(),
        ),
      },
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: localColorCode.ccBackgroundColor,
        brightness: localColorCode.ccBrightness,
      ),
    );
  }
}
