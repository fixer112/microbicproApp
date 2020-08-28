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
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) => Home(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( 
        child: Padding( padding: EdgeInsets.all(30), child: Row(
          children: [
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Container(
                  width: 80,
                  child: FittedBox(
                    child: Image.asset('assets/img/fakelogo.png'),
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 20,),*/
                Widgets.text('Microbic Pro', size: 40, color: primaryColor, weight: FontWeight.bold, align: TextAlign.center, family: 'PicedownBl' ),
                SizedBox(height: 10,),
                Widgets.text('wordly clinical diagnostics', color: primaryColor),
              ],
            )),
          ],
        ),
      )),
    );
  }
}