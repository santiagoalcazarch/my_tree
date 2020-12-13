
import 'package:flutter/material.dart';

import 'landing.dart';

class MaterialAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        appBarTheme: AppBarTheme( centerTitle: true, color: Color(0xFFC0D0C5) ),
        floatingActionButtonTheme: FloatingActionButtonThemeData( backgroundColor: Color(0xFFC0D0C5) )
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': ( BuildContext context ) {
          return LandingScreen();
        }
      },
    );
  }
}