import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/home_page.dart';

void main(){ 
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => MyHomePage(),
      },
      theme: 
      buildLightTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Редактируем тему
ThemeData buildLightTheme() {

  final ThemeData base = ThemeData.light();

  return base.copyWith(
    primaryColor: Color(0xFFDE3371),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      labelStyle: TextStyle(
        color: Color(0xFFDE3371),
        fontSize: 24.0
      ),
    ),
  );
}

