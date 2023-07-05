import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/Widget/menu.dart';
import 'package:flutter_mobile/src/pages/dashboardPage.dart';
import 'loginPage.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  Splash({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Sistem ',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'Inventori ',
              style: TextStyle(color: Color(0xff000081), fontSize: 35),
            ),
            TextSpan(
              text: 'Polindra',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff85a7c7), Color(0xff4d87b7)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 30),
            _title()
          ],
        ),
      ),
    );
  }
}
