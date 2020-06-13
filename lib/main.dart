import 'package:flutter/material.dart';
import 'package:gradbatch2020/widgets/developerInfo.dart';
import 'package:gradbatch2020/widgets/studentList.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/core.dart';

import './class/colorCodeNotifier.dart';
import './class/actualColorCodes.dart';

import './widgets/myHomePage.dart';
import './widgets/developerInfo.dart';
import './widgets/detailInfo.dart';
import './widgets/logInPage.dart';

void main() {
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhia31ifWN9Z2FoYmF8YGJ8ampqanNiYmlmamlmanMDHmgyMTs6OTonfTIjPCc6ODIhYmZlEzQ+Mjo/fTA8Pg==');
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
      initialRoute: '/LogInPage',
      routes: {
        '/': (context) => Scaffold(
              body: MyHomePage(),
            ),
        '/DeveloperInfo': (context) => Scaffold(
              body: DeveloperInfo(),
            ),
        '/StudentList': (context) => Scaffold(
              body: StudentList(),
            ),
        '/DetailInfo': (context) => Scaffold(
              body: DetailInfo(),
            ),
        '/LogInPage': (context) => Scaffold(
              body: LogInPage(),
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
