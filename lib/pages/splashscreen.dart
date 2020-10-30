import 'package:flutter/material.dart';
import 'package:microbicpro/pages/auth/login.dart';
import 'package:microbicpro/widgets/widgets.dart';

import '../values.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.max,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              child: Image.asset('assets/img/logo.png'),
            ),
            Widgets.text('Promoting Rational Use of Antimicrobials',
                color: primaryColor, style: FontStyle.italic, size: 12),
          ],
        ),
      ),
    );
  }
}
