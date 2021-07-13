import 'package:flutter/material.dart';
import 'package:moire_app/screens/moire_page.dart';
import 'package:moire_app/screens/splash_page.dart';
import 'package:moire_app/screens/test_page.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moire Playground',
      theme: themeData,
      // Screen IDS initiated as static vars in respective screens
      initialRoute: SplashPage.id,
      routes: {
        SplashPage.id: (context) => SplashPage(),
        MoirePage.id: (context) => MoirePage(),
        TestPage.id: (context) => TestPage(),
      },
    );
  }
}
