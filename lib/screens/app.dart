
import 'package:flutter/material.dart';

import 'landing.dart';

class MaterialAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': ( BuildContext context ) {
          return LandingScreen();
        }
      },
    );
  }
}