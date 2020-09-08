import 'package:flutter/material.dart';
import 'package:microbicpro/pages/home.dart';
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
            builder: (BuildContext context) => Home(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: Row(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  child: Image.asset('assets/img/logo.jpeg'),
                ),
                /*

                SizedBox(height: 20,),*/
                /* Widgets.text('MicrobicPro',
                    size: 40,
                    color: primaryColor,
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                    family: 'PicedownBl'), */

                //Image.asset('assets/img/logo.jpeg'),
                SizedBox(
                  height: 10,
                ),
                Widgets.text('Promoting Rational Use of Antimicrobials',
                    color: primaryColor, style: FontStyle.italic),
              ],
            )),
          ],
        ),
      )),
    );
  }
}
