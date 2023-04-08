import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}
